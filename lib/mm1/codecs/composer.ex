defmodule MM1.Codecs.Composer do
  alias MM1.Result

  def decode <<>>, module do
    %Result{module: module, err: :insufficient_bytes}
  end

  def decode bytes, module do
    results = module.codecs()
    |> List.foldl([%{rest: bytes, err: nil}], &decode_rest/2)

   error = hd(results).err

    if (error != nil) do
      %Result{module: module, err: error, value: [], bytes: bytes}
    else
     results |> Enum.reverse |> tl |> compose_result(module)
    end
  end

  defp decode_rest codec, results do
    previous_result = hd(results)
    result = case previous_result do
      %{err: nil} -> codec.decode(previous_result.rest)
      _ -> previous_result
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

  defp compose_result results, module do
    %Result{
      module: module,
      value:  Enum.map(results, & &1.value),
      bytes:  List.foldl(results, <<>>, & &2 <> &1.bytes),
      rest:   Enum.at(results, -1).rest
    }
  end
end
