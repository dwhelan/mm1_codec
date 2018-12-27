defmodule MMS.TextTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Text,
      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1>>,        :invalid_string    },
        {<<"string">>, :missing_terminator},
      ],

      encode_errors: [
        {<<1, 0>>, :invalid_string},
        {:not_a_string, :invalid_string},
      ]
end
