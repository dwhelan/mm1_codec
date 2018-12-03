defmodule MM1.Codecs.Checks do
  defmacro __using__(_opts) do
    quote do
      alias MM1.Result

      def decode <<>>, module do
        %Result{module: module, err: :insufficient_bytes}
      end

      def new nil, module do
        %Result{module: module, err: :value_cannot_be_nil}
      end
    end
  end
end

defmodule MM1.Codecs.Wrapper do
  alias MM1.Result

  use MM1.Codecs.Checks

  def decode bytes, module do
    bytes |> module.codec().decode |> wrap(module)
  end

  def encode result, module do
    result.value |> module.codec().encode
  end

  def new value, module do
    value.value |> module.codec().new |> wrap(module)
  end

  defp wrap result, module do
    value = %Result{result | rest: <<>>}
    %Result{result | module: module, value: value}
  end
end
