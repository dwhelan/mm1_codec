defmodule MM1.CcTest do
  alias MM1.{Result, Headers, Cc}
  import Cc
  use MM1.CodecTest

  def bytes do
    <<Headers.header_byte(Cc), "abc", 0>>
  end

  def result do
    %Result{module: Cc, value: "abc", bytes: bytes()}
  end
end
