defmodule MM1.Codecs.Composer do
  def decode <<>>, codec1, codec2, module do
    %MM1.Result{module: module, err: :insufficient_bytes}
  end

  def new nil, codec1, codec2, module do
    %MM1.Result{module: module, err: :value_cannot_be_nil}
  end

  def decode bytes, codec1, codec2, module do
    result1 = codec1.decode bytes
    result2 = codec2.decode result1.rest
    compose_result result1, result2, module
  end

  def encode result, codec1, codec2, module do
    new(result.value, codec1, codec2, module).bytes
  end

  def new [value1, value2], codec1, codec2, module do
    result1 = codec1.new value1
    result2 = codec2.new value2
    compose_result result1, result2, module
  end

  defp compose_result result1, result2, module do
    %MM1.Result{module: module, value: [result1.value, result2.value], bytes: result1.bytes <> result2.bytes, rest: result2.rest}
  end
end
