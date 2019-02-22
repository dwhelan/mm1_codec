defmodule MMS.AddressTest do
  use MMS.CodecTest

    use MMS.TestExamples,
      codec: MMS.Address,

      examples: [
        { "email@address\0",        {"email@address", ""}  },
        { "1234567890/TYPE=PLMN\0", {"1234567890", "PLMN"} },
        { "0.0.0.0/TYPE=IPv4\0",    {"0.0.0.0", "IPv4"}    },
        { ":/TYPE=IPv6\0",          {":", "IPv6"}          },
        { "address/TYPE=other\0",   {"address", "other"}   },
      ],

      decode_errors: [
        { << "x" >>, {:address, "x", [:text, :missing_end_of_string_0]} },
      ],

      encode_errors: [
        { {"email@address\0", ""}, {:address, {"email@address\0", ""}, [:text, :contains_end_of_string_0]} },
      ]
end
