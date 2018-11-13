defmodule Mm1.Result do
  defstruct value: nil, bytes: nil, rest: nil, module: nil
end

defmodule Mm1Codec do
  @moduledoc """
  """

  alias Mm1.Result

  def decode <<octet, rest::binary>> do
    struct Result, %{value: octet, bytes: <<octet>>, rest: rest, module: __MODULE__}
  end
end
