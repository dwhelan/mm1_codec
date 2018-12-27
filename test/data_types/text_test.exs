defmodule MMS.TextTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Text,
      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1>>,        :invalid_text      },
        {<<"string">>, :missing_terminator},
      ],

      encode_errors: [
        {<<1, 0>>,      :invalid_text},
        {:not_a_string, :invalid_text},
      ]
end
