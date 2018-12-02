defmodule MM1.Codecs.Composer do
  alias MM1.Result

  def decode <<>>, module do
    %Result{module: module, err: :insufficient_bytes}
  end

  def decode bytes, module do
    results =
      module.codecs()
      |> List.foldl([%Result{rest: bytes}], &decode_rest/2)
      |> Enum.reverse
      |> tl

    if last(results).err do
      %Result{module: module, err: last(results).err, value: value(results), bytes: bytes}
    else
      compose_result results, module
    end
  end

  defp decode_rest codec, results do
    previous = hd results

    result = case previous do
      %{err: nil} -> codec.decode previous.rest
      _           -> %Result{module: codec, err: previous.err}
    end

    [result | results]
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
    |> compose_result(module)
  end

  defp value results do
    results
    |> Enum.map(& &1.value)
    |> Enum.filter(&!is_nil(&1))
  end

  defp compose_result results, module do
    %Result{
      module: module,
      value: value(results),
      bytes: List.foldl(results, <<>>, & &2 <> &1.bytes),
      rest: last(results).rest
    }
  end

  defp last results do
    Enum.at results, -1
  end
end
