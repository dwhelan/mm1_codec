defmodule MMS.AddressTest do
  use MMS.CodecTest
  import MMS.Address

  codec_examples [
    {"email",        "email@address\0",             {"email@address", ""}},
    {"phone number", "1234567890/TYPE=PLMN\0",      {"1234567890",    "PLMN"}},
    {"ipv4",         "0.0.0.0/TYPE=IPv4\0",         {"0.0.0.0",       "IPv4"}},
    {"ipv6",         ":/TYPE=IPv6\0",               {":",             "IPv6"}},
    {"custom",       "address/TYPE=address-type\0", {"address",       "address-type"}},
  ]

  decode_errors [
    {"missing end of string",  <<"a">> },
  ]

  encode_errors [
    {"invalid address", {"a\0", ""},   {:address, {"a\0", ""},   [:text, :contains_end_of_string]} },
    {"invalid address type", {"a",   "\0"}, {:address, {"a",   "\0"}, [:text, :contains_end_of_string]} },
  ]
end
