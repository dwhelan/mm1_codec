defmodule MM1.Codecs.Wrapper do
  alias MM1.Result

  defmacro __using__(opts) do
    quote do
      import MM1.Codecs.Wrapper
      use MM1.Codecs.Extender
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

defmodule MM1.Codecs2.Wrapper do
  defmacro wrap codec do
    quote do
      import WAP.Guards

      @codec unquote(codec)

      def decode bytes do
        bytes |> @codec.decode |> value(& {&1, @codec})
      end

      def encode {value, codec} do
        value |> @codec.encode |> other({value, codec})
      end
    end
  end
end
