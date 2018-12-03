defmodule MM1.Codecs.Wrapper do
  alias MM1.Result

  use MM1.Codecs.Checks

  defmacro __using__(opts) do
    quote do
      import MM1.Codecs.Wrapper

      def decode bytes do
        decode bytes, __MODULE__
      end

      def encode result do
        encode result, __MODULE__
      end

      def new values do
        new values, __MODULE__
      end
    end
  end

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
