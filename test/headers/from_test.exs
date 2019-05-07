defmodule MMS.FromTest do
  use MMS.CodecTest

  import MMS.From

  codec_examples [
#    {"min length", {<<0>>,  <<>>},          0},
  ]

  decode_errors [
#    { "insufficient bytes",   <<5, "rest">>, required_bytes: 5, available_bytes: 4},
  ]

  encode_errors [
#    { "invalid short length", 31, :out_of_range},
  ]

  use MMS.TestExamples,
      codec: MMS.From,

      examples: [
        { << l(3), 128, "@\0" >>, {"@", ""}         },
#        { << l(1), 129        >>, :insert_address_token },
      ],

      decode_errors: [
#        { << l(0) >>,              {:from, <<l(0)>>,                [:short_integer, :no_bytes] } },
#        { << l(3), 0,    "@\0" >>, {:from, << l(3), 0,    "@\0" >>, [:short_integer, {:out_of_range, 0}] } },
#        { << l(2), s(0), "@" >>,   {:from, << l(2), s(0), "@"   >>, [:address, :text, :missing_end_of_string] } },
#        { << l(4), s(1), "@\0" >>, {:value_length, << l(4), s(1), "@\0" >>,      %{available_bytes: 3, short_length: 4}}}
      ],

      encode_errors: [
      ]
end
