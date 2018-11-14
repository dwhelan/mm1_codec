defmodule MM1.Message do
  require WAP.Octet

  alias MM1.{Result, Error}

  def decode bytes do
    octet_result = bytes |> WAP.Octet.decode
    struct Result, %{value: octet_result, bytes: <<>>, rest: <<>>, module: __MODULE__}
  end
end
