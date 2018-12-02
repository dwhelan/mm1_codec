defmodule MM1.Codecs.Wrapper do
  def decode <<>>, module, _codec do
    %MM1.Result{module: module, err: :insufficient_bytes}
  end

  def decode bytes, module, codec do
    bytes |> codec.decode |> wrap(module)
  end

  def encode result, _module, codec do
    result.value |> codec.encode
  end

  def new nil, module, _codec do
    %MM1.Result{module: module, err: :value_cannot_be_nil}
  end

  def new value, module, codec do
    value.value |> codec.new |> wrap(module)
  end

  defp wrap result, module do
    %MM1.Result{result | module: module, value: %MM1.Result{result | rest: <<>>}, bytes: <<>>}
  end
end
