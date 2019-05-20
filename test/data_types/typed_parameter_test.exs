defmodule MMS.TypedParameterTest do
  use MMS.CodecTest
  import MMS.TypedParameter

  codec_examples [
    {"q",                       <<s(0x00), 1>>,          {:q,                         "00"}},
    {"charset",                 <<s(0x01), s(3)>>,       {:charset,                   :ASCII}},
    {"level",                   <<s(0x02), 0b10000000>>, {:level,                     {0, 0}}},
    {"type",                    <<s(0x03), s(0)>>,       {:type,                      0}},
    {"name (deprecated)",       <<s(0x05), "a\0">>,      {:"name (deprecated)",       "a"}},
    {"file_name (deprecated)",  <<s(0x06), "a\0">>,      {:"file_name (deprecated)",  "a"}},
    {"differences",             <<s(0x07), "a\0">>,      {:differences,               "a"}},
    {"padding",                 <<s(0x08), s(0)>>,       {:padding,                   0}},
    {"type_multipart",          <<s(0x09), s(0)>>,       {:type_multipart,            0}},
    {"start (deprecated)",      <<s(0x0A), "a\0">>,      {:"start (deprecated)",      "a"}},
    {"start_info (deprecated)", <<s(0x0B), "a\0">>,      {:"start_info (deprecated)", "a"}},
    {"comment (deprecated)",    <<s(0x0C), "a\0">>,      {:"comment (deprecated)",    "a"}},
    {"domain (deprecated)",     <<s(0x0D), "a\0">>,      {:"domain (deprecated)",     "a"}},
    {"max_age",                 <<s(0x0E), s(0)>>,       {:max_age,                   0}},
    {"path (deprecated)",       <<s(0x0F), "a\0">>,      {:"path (deprecated)",       "a"}},
    {"secure",                  <<s(0x10), 0>>,          {:secure,                    :no_value}},
    {"sec",                     <<s(0x11), s(0)>>,       {:sec,                       0}},
    {"mac",                     <<s(0x12), "a\0">>,      {:mac,                       "a"}},
    {"creation_date",           <<s(0x13), l(1), 0>>,    {:creation_date,             DateTime.from_unix! 0}},
    {"modification_date",       <<s(0x14), l(1), 0>>,    {:modification_date,         DateTime.from_unix! 0}},
    {"read_date",               <<s(0x15), l(1), 0>>,    {:read_date,                 DateTime.from_unix! 0}},
    {"size",                    <<s(0x16), s(0)>>,       {:size,                      0}},
    {"name",                    <<s(0x17), "a\0">>,      {:name,                      "a"}},
    {"file_name",               <<s(0x18), "a\0">>,      {:file_name,                 "a"}},
    {"start",                   <<s(0x19), "a\0">>,      {:start,                     "a"}},
    {"start_info",              <<s(0x1A), "a\0">>,      {:start_info,                "a"}},
    {"comment",                 <<s(0x1B), "a\0">>,      {:comment,                   "a"}},
    {"domain",                  <<s(0x1C), "a\0">>,      {:domain,                    "a"}},
    {"path",                    <<s(0x1D), "a\0">>,      {:path,                      "a"}},
  ]

  decode_errors [
    {"Well-known-parameter-token", << s 30>>},
    {"Typed-value",                << s(8), 1>>},
  ]

  encode_errors [
    {"Well-known-parameter-token",  {:bad_token, 0}},
    {"Typed-value",                 {:q, :bad_value}},
  ]
end
