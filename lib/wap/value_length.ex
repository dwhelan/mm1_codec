defmodule WAP.ValueLength do
  use MM1.BaseCodec
  alias WAP.{ShortLength, Uintvar}

  @length_quote 31

  def decode(<<length, _::binary>> = bytes) when length <= 30 do
    bytes |> ShortLength.decode |> return
  end

  def decode <<@length_quote, bytes::binary>> do
    bytes |> Uintvar.decode |> prepend_length_quote |> return
  end

  def new(length) when length <= 30 do
    length |> ShortLength.new |> return
  end

  def new length do
    length |> Uintvar.new |> prepend_length_quote |> return
  end

  defp prepend_length_quote result do
    %Result{result | bytes: <<@length_quote>> <> result.bytes}
  end
end
