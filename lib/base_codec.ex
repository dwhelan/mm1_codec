defmodule MM1.BaseCodec do

  defmacro __using__(_opts) do
    quote do
      alias MM1.Result

      def decode <<>> do
        error :insufficient_bytes
      end

      defp value(val, bytes, rest) when is_binary(bytes) do
        return %Result{value: val, bytes: bytes, rest: rest}
      end

      defp value val, count \\ 0, bytes \\ <<>> do
        {consumed, rest} = String.split_at bytes, count
        return %Result{value: val, bytes: consumed, rest: rest}
      end

      defp error description do
        return %Result{value: {:err, description}}
      end

      defp return %Result{} = result do
        %Result{result | module: __MODULE__}
      end
    end
  end
end
