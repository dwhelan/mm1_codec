defmodule Mm1Codec do
  @moduledoc """
  """

  alias Mm1.Result

  def decode <<octet, bytes::binary>> do
    struct Result, %{value: octet, bytes: <<octet>>}
  end
end
