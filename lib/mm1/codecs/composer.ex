defmodule MM1.Codecs.Composer do
  alias MM1.Result

  def decode <<>>, module do
    %Result{module: module, err: :insufficient_bytes}
  end

  def decode bytes, module do
    module.codecs()
    |> List.foldl([%Result{rest: bytes}], &decode_rest/2)
    |> Enum.reverse
    |> tl
    |> composed_result(module, bytes)
  end

  defp decode_rest codec, results do
    previous = hd results
    if previous.err, do: results, else: [codec.decode(previous.rest) | results]
  end

  def encode result, module do
    new(result.value, module).bytes
  end

  def new nil, module do
    %Result{module: module, err: :value_cannot_be_nil}
  end

  def new values, module do
    module.codecs()
    |> Enum.with_index
    |> Enum.map(fn {codec, index} -> codec.new(Enum.at(values, index)) end)
    |> composed_result(module)
  end

  defp composed_result results, module, bytes \\ <<>> do
    if error(results) do
      %Result{module: module, value: value(results), err: error(results), bytes: bytes}
    else
      %Result{module: module, value: value(results), bytes:  bytes(results), rest:   rest(results)}
    end
  end

  defp value results do
    results |> Enum.map(& &1.value)
  end

  defp error results do
    results |> Enum.find_value(& &1.err)
  end

  defp bytes results do
    results |> List.foldl(<<>>, & &2 <> &1.bytes)
  end

  defp rest results do
    (results |> Enum.at(-1)).rest
  end
end
