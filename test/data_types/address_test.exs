defmodule MMS.AddressTest do
  use MMS.CodecTest

    use MMS.TestExamples,
      codec: MMS.Address,

      examples: [
#        { "email@address\0",         {"email@address", :email}          },
        { "1234567890/TYPE=PLMN\0",  {"1234567890", "PLMN"}             },
        { "0.0.0.0/TYPE=IPv4\0",     {"0.0.0.0", "IPv4"}             },
#        { ":/TYPE=IPv6\0",           {":", :ipv6} },
#        { "address/TYPE=other\0",    {"address", "other"}     },
      ],

      decode_errors: [
#        { << "x" >>,                   {:address, "x",                    [:text, :missing_end_of_string_0]} },
#        { << "x\0" >>,                 {:address, "x\0",                 :invalid_email_address}        },
#        { << "x.0.0.0/TYPE=IPv4\0" >>, {:address, "x.0.0.0/TYPE=IPv4\0", :ipv4_address }        },
#        { << "::x/TYPE=IPv6\0" >>,     {:address, "::x/TYPE=IPv6\0",     :ipv6_address }        },
        ]    ,

      encode_errors: [
#        { "email@address\0",      {:address, "email@address\0",      [:text, :contains_end_of_string_0]} },
#        { {"x", "PLMN"},          {:address, {"x", "PLMN"},          :reserved_type} },
#        { {"x", "IPv4"},          {:address, {"x", "IPv4"},          :reserved_type} },
#        { {"x", "IPv6"},          {:address, {"x", "IPv6"},          :reserved_type} },
#        { {"x", 0, 0, 0},             {:address, {"x", 0, 0, 0},             :ipv4_address}     },
#        { {"x", 0, 0, 0, 0, 0, 0, 0}, {:address, {"x", 0, 0, 0, 0, 0, 0, 0}, :ipv6_address}     },
      ]
end
