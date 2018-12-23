defmodule MMS.Foo do
  defmacro __using__ opts do
    quote bind_quoted: [opts: opts] do
      @codecs opts[:codecs]
      @check  opts[:check]

      import MMS.OkError

      def decode bytes do
        do_decode bytes, @codecs, [], nil
      end

      defp do_decode rest, [], values, _state do
        return values, rest
      end

      defp do_decode bytes, [codec | codecs], values, state do
        case codec.decode bytes, codec do
          {:ok,    {value, rest}} -> check rest, [codec | codecs], [value | values], state
          {:error, reason}        -> error codec, reason
        end
      end

      if @check do
        def check rest, codecs, values, state do
          case @check.(rest, codecs, values, state) do
            {:ok,    state}  -> do_decode rest, codecs, values, state
            {:error, reason} -> error hd{codecs}, reason
          end
        end
      else
        def check rest, codecs, values, state do
          do_decode rest, codecs, values, state
        end
      end

      def encode values do
        do_encode Enum.zip(values, @codecs), []
      end

      defp do_encode [], value_bytes do
        ok value_bytes |> Enum.reverse |> Enum.join
      end

      defp do_encode [{value, codec} | values], value_bytes do
        case codec.encode value do
          {:ok,    bytes}  -> do_encode values, [bytes | value_bytes]
          {:error, reason} -> error codec, reason
        end
      end

      defp return values, rest do
        ok Enum.reverse(values), rest
      end
    end
  end
end
