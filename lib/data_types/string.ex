defmodule MMS.String do
  import MMS.OkError

  def decode <<bytes::binary>> do
    bytes |> String.split(<<0>>, parts: 2) |> decode
  end

  def decode [string | [rest]] do
    ok string, rest
  end

  def decode [_string | []] do
    error :missing_terminator
  end

  def encode string do
    ok string <> <<0>>
  end
end
