defmodule MM1.Codecs.Wrapper do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      import MM1.Codecs.Decorator

      decorate codec do
        defp map_result result do
          %MM1.Result{result | value: result, bytes: <<>>}
        end

        defp encode_arg result do
          result.value
        end

        defp map_value value do
          value
        end
      end
    end
  end
end
