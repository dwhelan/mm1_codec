defmodule MM1.Codecs.Composer do
  def decode bytes, codec1, codec2, module do
    result1 = bytes |> codec1.decode
    result2 = result1.rest |> codec2.decode
    %MM1.Result{module: module, value: [result1.value, result2.value], bytes: result1.bytes <> result2.bytes, rest: result2.rest}
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
