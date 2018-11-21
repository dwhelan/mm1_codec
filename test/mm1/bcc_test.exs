defmodule MM1.BccTest do
  alias MM1.{Result, Headers, Bcc}
  import Bcc
  use MM1.CodecTest

  def bytes do
    <<Headers.header_byte(Bcc), "abc", 0>>
  end

  def result do
    %Result{module: Bcc, value: "abc", bytes: bytes()}
  end
end
