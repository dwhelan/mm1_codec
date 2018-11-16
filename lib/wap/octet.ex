defmodule WAP.Octet do
  @moduledoc """
  """

  use MM1.BaseCodec

  def decode <<octet, rest::binary>> do
    return %MM1.Result{value: octet, bytes: <<octet>>, rest: rest}
  end

  def encode result  do
    <<result.value>>
  end
end

