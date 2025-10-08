#include "utf-8/neither-sjis-nor-ujis.h"
// expected-warning@* {{interpreting as UTF-8}}
constexpr auto North = –k;
constexpr auto South = “ì;
constexpr auto East = “Œ;
constexpr auto West = ¼;
