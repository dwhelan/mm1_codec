defmodule MM1.Codecs.Wrapper do
  def decode bytes, codec, module do
    bytes |> codec.decode |> wrap(module)
  end

  def encode result, codec, _module do
    result.value |> codec.encode
  end

  def new value, codec, module do
    value |> codec.new |> wrap(module)
  end

  defp wrap result, module do
    %MM1.Result{result | module: module, value: result, bytes: <<>>}
  end
end
