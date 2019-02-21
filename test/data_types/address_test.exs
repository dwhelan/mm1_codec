defmodule MMS.AddressTest do
  use MMS.CodecTest

    use MMS.TestExamples,
      codec: MMS.Address,

      examples: [
        { "email@address\0",         "email@address"          },
        { "1234567890/TYPE=PLMN\0",  {"1234567890", :phone}             },
#        { "0.0.0.0/TYPE=IPv4\0",     {0, 0, 0, 0}             },
#        { ":/TYPE=IPv6\0",           {0, 0, 0, 0, 0, 0, 0, 0} },
#        { "address/TYPE=other\0",    {"address", "other"}     },
      ],

      decode_errors: [
#        { << "x" >>,                   {:address, "x",                    [:text, :missing_end_of_string_0_byte]} },
        { << "x\0" >>,                 {:address, "x\0",                 :invalid_email_address}        },
        { << "!/TYPE=PLMN\0" >>,       {:address, "!/TYPE=PLMN\0",       :invalid_phone_number }        },
#        { << "x.0.0.0/TYPE=IPv4\0" >>, {:address, "x.0.0.0/TYPE=IPv4\0", :ipv4_address }        },
#        { << "::x/TYPE=IPv6\0" >>,     {:address, "::x/TYPE=IPv6\0",     :ipv6_address }        },
        ]    ,

      encode_errors: [
        { "email@address\0",          {:address, "email@address\0",          [:text, :contains_end_of_string_0]} },
        { {"x", :phone},               {:address, {"x", :phone},                        :invalid_phone_number}     },
#        { {"x", 0, 0, 0},             {:address, {"x", 0, 0, 0},             :ipv4_address}     },
#        { {"x", 0, 0, 0, 0, 0, 0, 0}, {:address, {"x", 0, 0, 0, 0, 0, 0, 0}, :ipv6_address}     },
      ]
end
