defmodule MM1.Result do
  defstruct [:value, :bytes, :rest, :module]
end

defmodule Mm1Codec do
  @moduledoc """
  """

  alias MM1.Result

  def decode <<octet, rest::binary>> do
    struct Result, %{value: octet, bytes: <<octet>>, rest: rest, module: __MODULE__}
  end

  def decode <<>> do
    {:err, :insufficient_bytes}
  end
end
