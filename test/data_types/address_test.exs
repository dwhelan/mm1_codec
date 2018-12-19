defmodule MMS.AddressTest do
  use ExUnit.Case

  alias MMS.Address

  string30     = String.duplicate "x", 30
  length_quote = 31

  use MMS.TestExamples,
      codec: Address,
      examples: [
        {<<"email@address",        0>>, "email@address"},
        {<<"1234567890/TYPE=PLMN", 0>>, "1234567890"},
        {<<"0.0.0.0/TYPE=unknown", 0>>, "0.0.0.0/TYPE=unknown"},
        {<<"0.0.0.0/TYPE=IPv4",    0>>, {0, 0, 0, 0}},
        {<<":1/TYPE=IPv6",         0>>, {0, 0, 0, 0, 0, 0, 0, 1}},

        # Encoded with short length
#        {<< 3, 0xea, "x", 0>>,          {:csUTF8,    "x"}},
#        {<< 5, 2, 0x03, 0xe8, "x", 0>>, {:csUnicode, "x"}},

        # Encoded with uint32 length
#        {<<length_quote, 32, 0xea>> <> string30 <> <<0>>, {:csUTF8, string30}},
      ],

      decode_errors: [
        {<<"x", 0>>,                 :invalid_email       },
        {<<"@/TYPE=PLMN", 0>>,       :invalid_phone_number},
        {<<"x.0.0.0/TYPE=IPv4", 0>>, :invalid_ipv4_address},
#        {<<3, 0xea, "x">>, :missing_terminator},
#        {<<"x">>,          :missing_terminator},
#
#        {<<2, 0xea, "x", 0>>,                             :incorrect_length}, #  short length
#        {<<length_quote, 33, 0xea>> <> string30 <> <<0>>, :incorrect_length}, # uint32 length
      ]
end

