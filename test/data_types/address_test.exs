defmodule MMS.AddressTest do
  use MMS.Test2

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
        { << l(3),  s(106), "@\0" >>,                 {"@",                      :csUTF8} },
        { << l(13), s(106), "1/TYPE=PLMN\0" >>,       {"1",                      :csUTF8} },
        { << l(10), s(106), "v/TYPE=t\0" >>,          {{"v", "t"},               :csUTF8} },
        { << l(19), s(106), "0.0.0.0/TYPE=IPv4\0" >>, {{0, 0, 0, 0},             :csUTF8} },
        { << l(13), s(106), ":/TYPE=IPv6\0" >>,       {{0, 0, 0, 0, 0, 0, 0, 0}, :csUTF8} },
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
