defmodule MMS.FromTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.From,

      examples: [
        { << l(3), 128, "@\0" >>, {"@", ""}         },
        { << l(1), 129        >>, :insert_address_token },
      ],

      decode_errors: [
        { << l(0) >>,              {:from, <<l(0)>>,                [:from_address, :no_bytes] } },
        { << l(3), 0,    "@\0" >>, {:from, << l(3), 0,    "@\0" >>, [:from_address, :short_integer, {:out_of_range, 0}] } },
        { << l(2), s(0), "@" >>,   {:from, << l(2), s(0), "@"   >>, [:from_address, :address, :text, :missing_end_of_string] } },
        { << l(4), s(1), "@\0" >>, {:from, << l(4), s(1), "@\0" >>, [:value_length, %{available_bytes: 3, short_length: 4}]} },
      ],

      encode_errors: [
      ]
end
