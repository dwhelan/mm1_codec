defmodule MMS.AddressTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Address,

      examples: [
        # address
        { "email@address\0",         "email@address"          },
        { "1234567890/TYPE=PLMN\0",  "1234567890"             },
        { "value/TYPE=unknown\0",    {"value", "unknown"}     },
        { "0.0.0.0/TYPE=IPv4\0",     {0, 0, 0, 0}             },
        { ":/TYPE=IPv6\0",           {0, 0, 0, 0, 0, 0, 0, 0} },

        #    length charset address
#        { << l(3),  s(106), "@\0" >>,                 [:csUTF8, "@"                      ] },
#        { << l(13), s(106), "1/TYPE=PLMN\0" >>,       [:csUTF8, "1"                      ] },
#        { << l(10), s(106), "v/TYPE=t\0" >>,          [:csUTF8, {"v", "t"}               ] },
#        { << l(19), s(106), "0.0.0.0/TYPE=IPv4\0" >>, [:csUTF8, {0, 0, 0, 0}             ] },
#        { << l(13), s(106), ":/TYPE=IPv6\0" >>,       [:csUTF8, {0, 0, 0, 0, 0, 0, 0, 0} ] },
      ],

      decode_errors: [
        { "x\0",                   :invalid_address },
        { "@/TYPE=PLMN\0",         :invalid_address },
        { "x.0.0.0/TYPE=IPv4\0",   :invalid_address },
        { "::x/TYPE=IPv6\0",       :invalid_address },
        { "@",                     :invalid_address },
        { << l(3), s(106), "@" >>, :invalid_address },
      ],

      encode_errors: [
        { :not_an_address, :invalid_address },
        { "0+",            :invalid_address },
        { {0, 0, 0},       :invalid_address },
      ]
end

defmodule MMS.Address2Test do
  use MMS.CodecTest

    use MMS.TestExamples,
      codec: MMS.Address2,

      examples: [
        { "email@address\0",         "email@address"          },
        { "1234567890/TYPE=PLMN\0",  "1234567890"             },
        { "0.0.0.0/TYPE=IPv4\0",     {0, 0, 0, 0}             },
        { ":/TYPE=IPv6\0",           {0, 0, 0, 0, 0, 0, 0, 0} },
        { "address/TYPE=other\0",    {"address", "other"}     },
      ],

      decode_errors: [
        { "x\0",                   {:invalid_address2, "x\0",                 :invalid_email_address} },
        { "!/TYPE=PLMN\0",         {:invalid_address2, "!/TYPE=PLMN\0",       :invalid_phone_number } },
        { "x.0.0.0/TYPE=IPv4\0",   {:invalid_address2, "x.0.0.0/TYPE=IPv4\0", :invalid_ipv4_address } },
        { "::x/TYPE=IPv6\0",       {:invalid_address2, "::x/TYPE=IPv6\0",     :invalid_ipv6_address } },
      ],

      encode_errors: [
        { "x",                        {:invalid_address2, "x",                        :invalid_phone_number} },
        { "email@address\0",          {:invalid_address2, "email@address\0",          {:invalid_text, "email@address\0", :contains_end_of_string_byte}} },
        { {"x", 0, 0, 0},             {:invalid_address2, {"x", 0, 0, 0},             :invalid_ipv4_address} },
        { {"x", 0, 0, 0, 0, 0, 0, 0}, {:invalid_address2, {"x", 0, 0, 0, 0, 0, 0, 0}, :invalid_ipv6_address} },
      ]
end
