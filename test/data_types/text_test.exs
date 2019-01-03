defmodule MMS.TextTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.Text,

      examples: [
        {<<0>>,           ""      },
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<1>>,        :invalid_text },
        {<<"string">>, :invalid_text },
      ],

      encode_errors: [
        {<<1, 0>>,      :invalid_text}, # does not start with text byte
        {"x\0",         :invalid_text}, # contains terminator
        {:not_a_string, :invalid_text},
      ]
end
