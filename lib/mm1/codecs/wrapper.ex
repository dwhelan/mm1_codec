defmodule MM1.Codecs2.Wrapper do
  defmacro wrap codec do
    quote do
      import MM1.OkError

      @codec unquote(codec)

      def decode bytes do
        bytes |> @codec.decode |> _wrap
      end

      def encode value do
        value |> unwrap |> @codec.encode
      end

      defp _wrap {:ok, {value, rest}} do
        ok {{@codec, value}, rest}
      end

      defp _wrap {:error, reason} do
        error {@codec, reason}
      end

      defp unwrap {codec, value} do
        value
      end
    end
  end
end
