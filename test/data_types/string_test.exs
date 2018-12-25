defmodule MMS.StringTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.String,
      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1>>,        :invalid_string    },
        {<<"string">>, :missing_terminator},
      ],

      encode_errors: [
        {:not_a_string, :invalid_string},
      ]
end
