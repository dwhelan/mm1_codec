defmodule MMS.Parameter do
  @moduledoc """
  8.4.2.4 Parameter

  Parameter = Typed-parameter | Untyped-parameter
  """

  use MMS.Codec
  import MMS.As

  alias MMS.{Tuple, TokenText, UntypedValue}

  def decode bytes do
    bytes
    |> Tuple.decode([TokenText, UntypedValue])
  end

  def encode {name, value} do
    {name, value}
    |> Tuple.encode([TokenText, UntypedValue])
  end
end
