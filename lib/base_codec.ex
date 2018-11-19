defmodule MM1.BaseCodec do

  defmacro __using__(_opts) do
    quote do
      alias MM1.Result

      def decode <<>> do
        error :insufficient_bytes
      end

      defp value(val, bytes \\ <<>>, rest \\ <<>>) when is_binary(bytes) do
        return %Result{value: val, bytes: bytes, rest: rest}
      end

      defp error description, bytes \\ <<>>, rest \\ <<>> do
        return %Result{value: {:err, description}, bytes: bytes, rest: rest}
      end

      defp return %Result{} = result do
        %Result{result | module: __MODULE__}
      end
    end
  end
end
