defmodule MM1.MessageTest do
  use ExUnit.Case

  alias MM1.{Result, Headers, Message}

  use MM1.Codecs.TestExamples,
      codec: Message,
      examples: [
        {
          <<0x81, "x", 0, 0x82, "x", 0>>,
          %Result{
            bytes: <<0x81, "x", 0, 0x82, "x", 0>>,
            module: Headers,
            value: [
              %Result{module: MM1.Bcc, value: "x", bytes: <<0x81, "x", 0>>, rest: <<0x82, "x", 0, "rest">>},
              %Result{module: MM1.Cc,  value: "x", bytes: <<0x82, "x", 0>>, rest: "rest"                  }
            ]
          }
        },
      ]
end
