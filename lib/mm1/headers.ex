defmodule MM1.Headers do
  require WAP.Octet

  alias MM1.{Result, Error}

  def decode bytes do
    octet_result = bytes |> MM1.Headers.decode |> return
  end

  def return %Result{rest: rest} = result do
    %Result{value: result, bytes: <<>>, rest: rest, module: __MODULE__}

  end

  def return %Error{} = error do
    %Error{value: error, bytes: <<>>, rest: <<>>, module: __MODULE__}
  end
end
