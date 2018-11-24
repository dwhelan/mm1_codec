defmodule MM1.BccTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias MM1.Bcc

  examples Bcc, [
    {<<Bcc.header_byte(), "abc", 0>>, "abc"}
  ]
end
