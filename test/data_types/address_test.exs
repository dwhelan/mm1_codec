defmodule MMS.Address2Test do
  use MMS.CodecTest

    use MMS.TestExamples,
      codec: MMS.Address,

      examples: [
        { "email@address\0",         "email@address"          },
        { "1234567890/TYPE=PLMN\0",  "1234567890"             },
        { "0.0.0.0/TYPE=IPv4\0",     {0, 0, 0, 0}             },
        { ":/TYPE=IPv6\0",           {0, 0, 0, 0, 0, 0, 0, 0} },
        { "address/TYPE=other\0",    {"address", "other"}     },
      ],

      decode_errors: [
        { "x\0",                   {:invalid_address, "x\0",                 :invalid_email_address} },
        { "!/TYPE=PLMN\0",         {:invalid_address, "!/TYPE=PLMN\0",       :invalid_phone_number } },
        { "x.0.0.0/TYPE=IPv4\0",   {:invalid_address, "x.0.0.0/TYPE=IPv4\0", :invalid_ipv4_address } },
        { "::x/TYPE=IPv6\0",       {:invalid_address, "::x/TYPE=IPv6\0",     :invalid_ipv6_address } },
      ],

      encode_errors: [
        { "x",                        {:invalid_address, "x",                        :invalid_phone_number} },
        { "email@address\0",          {:invalid_address, "email@address\0",          {:invalid_text, "email@address\0", :contains_end_of_string_0}} },
        { {"x", 0, 0, 0},             {:invalid_address, {"x", 0, 0, 0},             :invalid_ipv4_address} },
        { {"x", 0, 0, 0, 0, 0, 0, 0}, {:invalid_address, {"x", 0, 0, 0, 0, 0, 0, 0}, :invalid_ipv6_address} },
      ]
end
