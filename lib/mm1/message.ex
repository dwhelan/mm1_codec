defmodule MM1.Message do
  require WAP.Octet

  alias MM1.{Result, Error}

  def decode bytes do
    octet_result = bytes |> WAP.Octet.decode |> return
  end

  def return %Result{} = result do
    %Result{value: result, bytes: <<>>, rest: <<>>, module: __MODULE__}

  end

  def return %Error{} = error do
    %Error{value: error, bytes: <<>>, rest: <<>>, module: __MODULE__}
  end
end
