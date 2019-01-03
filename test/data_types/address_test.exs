defmodule MMS.AddressTest do
  use ExUnit.Case
  import MMS.Test

  alias MMS.Address

  use MMS.TestExamples,
      codec: Address,
      examples: [
        { << "email@address\0"        >>, "email@address"          },
        { << "1234567890/TYPE=PLMN\0" >>, "1234567890"             },
        { << "value/TYPE=unknown\0"   >>, {"value", "unknown"}     },
        { << "0.0.0.0/TYPE=IPv4\0"    >>, {0, 0, 0, 0}             },
        { << ":/TYPE=IPv6\0"          >>, {0, 0, 0, 0, 0, 0, 0, 0} },
        { << l(3), s(106), "@\0"      >>, {"@", :csUTF8}           },
      ],

      decode_errors: [
        { << "x\0"                 >>, :invalid_address    },
        { << "@/TYPE=PLMN\0"       >>, :invalid_address    },
        { << "x.0.0.0/TYPE=IPv4\0" >>, :invalid_address    },
        { << "::x/TYPE=IPv6\0"     >>, :invalid_address    },
        { << "@"                   >>, :invalid_encoded_string },
        { << l(3), s(106), "@"     >>, :invalid_encoded_string },
      ],

      encode_errors: [
        { :not_an_address, :invalid_address },
        { "0+",            :invalid_address },
        { {0, 0, 0},       :invalid_address },
      ]
end
