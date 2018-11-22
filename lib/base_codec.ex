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
        error :insufficient_bytes
      end

      defp value val, bytes \\ <<>>, rest \\ <<>> do
        return %Result{value: val, bytes: bytes, rest: rest}
      end

      defp error description, bytes \\ <<>>, rest \\ <<>> do
        return %Result{value: {:err, description}, bytes: bytes, rest: rest}
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
