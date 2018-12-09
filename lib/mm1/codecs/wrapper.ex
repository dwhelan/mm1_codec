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
        bytes |> @codec.decode |> wrap_value
      end

      def encode {_codec, value} do
        value |> @codec.encode
      end

      def wrap_value result do
        case result do
          {:error, reason       } -> {:error, {@codec, reason}}
          {:ok,    {value, rest}} -> {:ok,    {{@codec, value}, rest}}
        end
      end
    end
  end
end
