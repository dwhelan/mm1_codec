defmodule MMS.UntypedParameter do
  @moduledoc """
  Based on WAP-230-WSP-20010705-a: 8.4.2.4 Parameter

  Untyped-parameter = Token-text Untyped-value
  """

  use MMS.Codec

  alias MMS.{Tuple, TextString, UntypedValue}

  def decode(bytes) do
    bytes
    |> Tuple.decode([TextString, UntypedValue])
  end

  def encode({name, value}) do
    {name, value}
    |> Tuple.encode([TextString, UntypedValue])
  end
end
