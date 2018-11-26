defmodule MM1.BccTest do
  use ExUnit.Case

  alias MM1.Bcc

  use MM1.CodecExamples, module: Bcc,
    examples: [
      {<<Bcc.header_byte(), "abc", 0>>, "abc"}
    ]
end
