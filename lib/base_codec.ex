defmodule MM1.BaseCodec do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      alias MM1.Result

      if ! opts[:custom_encode] do
        def encode result do
          result.bytes
        end
      end

      def decode <<>> do
        error2 :insufficient_bytes
      end

      def new nil do
        value nil
      end

      defp value value, bytes \\ <<>>, rest \\ <<>> do
        return %Result{value: value, bytes: bytes, rest: rest}
      end

      defp error error, bytes \\ <<>>, rest \\ <<>> do
        return %Result{value: {:err, error}, bytes: bytes, rest: rest, err: error}
      end

      defp error2 error, value \\ nil, bytes \\ <<>>, rest \\ <<>> do
        return %Result{value: value, bytes: bytes, rest: rest, err: error}
      end

      defp return %Result{} = result do
        %Result{result | module: __MODULE__}
      end

      defp bytes ~> codec when is_binary(bytes) do
        return codec.decode bytes
      end

      defp previous ~> codec do
        result = codec.decode previous.rest
        previous_value = if is_tuple(previous.value), do: previous.value, else: {previous.value}
        return %Result{result | value: Tuple.append(previous_value, result.value), bytes: previous.bytes <> result.bytes}
      end
    end
  end
end
