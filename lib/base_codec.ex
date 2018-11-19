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
    end
  end
end
