defmodule MM1.Codecs.Composer do
  alias MM1.Result

  defmacro __using__(opts) do
    quote do
      import MM1.Codecs.Composer
      use MM1.Codecs.Extender
    end
  end

  def decode <<>>, module do
    %Result{module: module, err: :insufficient_bytes}
  end

  def decode bytes, module do
    module.codecs()
    |> List.foldl([%Result{rest: bytes}], &decode_rest/2)
    |> Enum.reverse
    |> tl
    |> composed_result(module)
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

  def new(values, module) when is_list(values) == false do
    %Result{module: module, err: :must_be_a_list, value: values}
  end

  def new values, module do
    codecs = module.codecs()

    if length(values) !== length(codecs) do
      %Result{module: module, err: :incorrect_list_length, value: values}
    else
      codecs
      |> Enum.with_index
      |> Enum.map(fn {codec, index} -> codec.new(Enum.at(values, index)) end)
      |> composed_result(module)
    end
  end

  defp composed_result results, module do
    %Result{module: module, value: value(results), err: error(results), bytes: bytes(results), rest: rest(results)}
  end

  defp value results do
    Enum.map(results, & &1.value)
  end

  defp error results do
    errors = Enum.map(results, & &1.err)
    if Enum.all?(errors, &is_nil &1), do: nil, else: errors
  end

  defp bytes results do
    {_, bytes} = List.foldl(results, {[%Result{}], <<>>},
      fn result, {results, bytes} ->
        if hd(results).err, do: {results, bytes}, else: {[result | results], bytes <> result.bytes}
      end)
    bytes
  end

  defp rest results do
    Enum.at(results, -1).rest
  end
end
