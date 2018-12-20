defmodule MMS.AddressTest do
  use ExUnit.Case

  alias MMS.Address

  use MMS.TestExamples,
      codec: Address,
      examples: [
        {<<"email@address",        0>>, "email@address"},
        {<<"1234567890/TYPE=PLMN", 0>>, "1234567890"},
        {<<"0.0.0.0/TYPE=unknown", 0>>, "0.0.0.0/TYPE=unknown"},
        {<<"0.0.0.0/TYPE=IPv4",    0>>, {0, 0, 0, 0}},
        {<<":1/TYPE=IPv6",         0>>, {0, 0, 0, 0, 0, 0, 0, 1}},

        # Encoded
        {<< 3, 0xea, "@", 0>>,          {:csUTF8,    "@"}},
      ],

      decode_errors: [
        {<<"x",                 0>>, :invalid_email       },
        {<<"@/TYPE=PLMN",       0>>, :invalid_phone_number},
        {<<"x.0.0.0/TYPE=IPv4", 0>>, :invalid_ipv4_address},
        {<<"::x/TYPE=IPv6",     0>>, :invalid_ipv6_address},
        {<<"@"                   >>, :missing_terminator  }, # Encoded string error
      ]
end
