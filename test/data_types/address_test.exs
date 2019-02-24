defmodule MMS.AddressTest do
  use MMS.CodecTest

    use MMS.TestExamples,
      codec: MMS.Address,

      eaamples: [
        { "email@address\0",             {"email@address", ""} },
        { "1234567890/TYPE=PLMN\0",      {"1234567890",    "PLMN"} },
        { "0.0.0.0/TYPE=IPv4\0",         {"0.0.0.0",       "IPv4"} },
        { ":/TYPE=IPv6\0",               {":",             "IPv6"} },
        { "address/TYPE=address-type\0", {"address",       "address-type"} },
      ],

      decode_errors: [
        { << "a" >>, {:address, "a", [:text, :missing_end_of_string]} },
      ],

      encode_errors: [
        { {"a\0", ""},   {:address, {"a\0", ""},   [:text, :contains_end_of_string]} },
        { {"a",   "\0"}, {:address, {"a",   "\0"}, [:text, :contains_end_of_string]} },
      ]
end
