defmodule WAP.Octet do
  @moduledoc """
  """

  alias MM1.{Result, Error}

  def decode <<octet, rest::binary>> do
    struct Result, %{value: octet, bytes: <<octet>>, rest: rest, module: __MODULE__}
  end

  def decode <<>> do
    %Error{bytes: <<>>, value: :insufficient_bytes, module: __MODULE__}
  end
end
