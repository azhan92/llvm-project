#include "utf-8/neither-sjis-nor-ujis.h"
// expected-warning@* {{interpreting as UTF-8}}
constexpr auto North = ÀÃ;
constexpr auto South = ∆Ó;
constexpr auto East = ≈Ï;
constexpr auto West = ¿æ;
