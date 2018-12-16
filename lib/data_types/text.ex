defmodule MMS.Text do
  import MMS.OkError

  def decode <<bytes::binary>> do
    bytes |> String.split(<<0>>, parts: 2) |> decode
  end

  def decode [text | [rest]] do
    ok text, rest
  end

  def decode [text | []] do
    error :missing_terminator
  end

  def encode text do
    ok text <> <<0>>
  end
end