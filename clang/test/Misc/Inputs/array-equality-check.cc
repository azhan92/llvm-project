// This file is used for some character encoding tests to compare two arrays.

#define STR1(X)  # X
#define STR(X)   STR1(X)

template <typename T, decltype(sizeof 0) N>
constexpr bool arrayEquals(const T (&a)[N], const T (&b)[N]) {
  for (auto idx = N - N; idx < N; ++idx)
    if (a[idx] != b[idx]) return false;
  return true;
}

const auto &a =
#include STR(HEADER1)
;

const auto &b =
#include STR(HEADER2)
;

static_assert(arrayEquals(a, b));
