// Test `-finput-charset` with an unrecognized character encoding.

// RUN: not %clang_cc1 -E -finput-charset invalid -o /dev/null %s 2>&1 | FileCheck %s
// CHECK: error: invalid value 'invalid' in '-finput-charset'
