defmodule MM1.BccTest do
  use ExUnit.Case

  alias MM1.Bcc

  header_byte = Bcc.header_byte()

  use MM1.CodecExamples, codec: Bcc,
    examples: [
      {<<header_byte, "abc", 0>>, "abc"}
    ]
end
