defmodule MMS.TextValueTest do
  use ExUnit.Case

  @quote_char 34

  use MMS.TestExamples,
      codec: MMS.TextValue,
      examples: [
        {<<0>>,                   :no_value },
        {<<"x", 0>>,              "x"       },
        {<<@quote_char, "x", 0>>, {"x"}     },
      ],

      decode_errors: [
        {<<128>>, :invalid_text_value },
      ],

      encode_errors: [
        {:not_a_text_value, :invalid_text_value},
      ]
end