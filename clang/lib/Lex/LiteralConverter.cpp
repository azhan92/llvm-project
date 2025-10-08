//===--- LiteralConverter.cpp - Translator for String Literals -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/Lex/LiteralConverter.h"
#include "clang/Basic/DiagnosticDriver.h"

using namespace llvm;

llvm::TextEncodingConverter *
LiteralConverter::getConverter(ConversionAction Action) {
  if (Action == ToSystemEncoding)
    return ToSystemEncodingConverter;
  else if (Action == FromInputEncoding)
    return FromInputEncodingConverter.get();  
  else if (Action == ToExecEncoding)
    return ToExecEncodingConverter;
  else
    return nullptr;
}

void LiteralConverter::setConvertersFromOptions(
    const clang::LangOptions &Opts, const clang::TargetInfo &TInfo,
    clang::DiagnosticsEngine &Diags) {
  using namespace llvm;
  InternalEncoding = "UTF-8";
  SystemEncoding = TInfo.getTriple().getDefaultTextEncoding();
  ExecEncoding = TInfo.getTriple().getDefaultTextEncoding();
  StringRef InputEncoding =
      Opts.InputEncoding.empty() ? InternalEncoding : Opts.InputEncoding;

  // Create converter between internal and system encoding
  if (InternalEncoding != SystemEncoding) {
    ErrorOr<TextEncodingConverter> ErrorOrConverter =
        llvm::TextEncodingConverter::create(InternalEncoding, SystemEncoding);
    if (!ErrorOrConverter)
      return;
    ToSystemEncodingConverter =
        new TextEncodingConverter(std::move(*ErrorOrConverter));
  }

  // Create converter between input encoding specified by finput-charset
  // and internal encoding.
  if (InputEncoding != InternalEncoding) {
    // TODO: When not using iconv, match charsets by normalized name.
    ErrorOr<TextEncodingConverter> ErrorOrConverter =
        llvm::TextEncodingConverter::create(InputEncoding, InternalEncoding);
    if (!ErrorOrConverter)
      Diags.Report(clang::diag::err_drv_invalid_value)
          << "-finput-charset" << InputEncoding;
    else
      FromInputEncodingConverter =
        std::make_unique<llvm::TextEncodingConverter>(std::move(*ErrorOrConverter));
  } else {
    FromInputEncodingConverter = nullptr;
  }

  // Create converter between internal and exec encoding specified
  // in fexec-charset option.
  if (InternalEncoding == ExecEncoding)
    return;
  ErrorOr<TextEncodingConverter> ErrorOrConverter =
      llvm::TextEncodingConverter::create(InternalEncoding, ExecEncoding);
  if (!ErrorOrConverter)
    Diags.Report(clang::diag::err_drv_invalid_value)
        << "-fexec-charset" << ExecEncoding;
  ToExecEncodingConverter =
      new TextEncodingConverter(std::move(*ErrorOrConverter));
}
