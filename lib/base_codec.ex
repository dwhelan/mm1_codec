defmodule MM1.BaseCodec do

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      alias MM1.Result


      @wrapped_module opts[:wrap]
      if @wrapped_module do
        def decode bytes do
          value @wrapped_module.decode bytes
        end

        def encode result do
          @wrapped_module.encode result.value
        end
      else
        if ! opts[:custom_encode] do
          def encode result do
            result.bytes
          end
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
