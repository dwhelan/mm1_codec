defmodule MM1.Codecs.Wrapper do
  def decode <<>>, codec1, module do
    %MM1.Result{module: module, err: :insufficient_bytes}
  end

  def new nil, codec1, module do
    %MM1.Result{module: module, err: :value_cannot_be_nil}
  end

  def decode bytes, codec, module do
    bytes |> codec.decode |> wrap(module)
  end

  def encode result, codec, _module do
    result.value |> codec.encode
  end

  def new value, codec, module do
    value.value |> codec.new |> wrap(module)
  end

  defp wrap result, module do
    %MM1.Result{result | module: module, value: result, bytes: <<>>}
  end
end
