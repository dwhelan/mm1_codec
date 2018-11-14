defmodule WAP.Octet do
  @moduledoc """
  """

  alias MM1.{Result, Error}

  def decode <<octet, rest::binary>> do
    struct Result, %{value: octet, bytes: <<octet>>, rest: rest, module: __MODULE__}
  end

  def decode <<>> do
    {:err, %Error{reason: :insufficient_bytes}}
  end
end
