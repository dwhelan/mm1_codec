defmodule MMS.FieldNameTest do
  use MMS.CodecTest
  alias MMS.FieldName

  use MMS.TestExamples,
      codec: FieldName,

      examples: [
        {<< s(0) >>, 0},
        {<< "a\0" >>, "a"},
      ],

      decode_errors: [
        {<< 0 >>, {:field_name, << 0 >>, [token_text: :must_have_at_least_one_token_char, short_integer: [out_of_range: 0]]}},
      ],

      encode_errors: [
        { -1, {:field_name, -1, [token_text: :out_of_range, short_integer: :out_of_range]}},
      ]
end

