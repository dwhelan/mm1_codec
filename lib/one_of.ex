defmodule MMS.OneOf do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.OkError

      @codecs opts[:codecs] || []
      @reason "invalid_#{__MODULE__ |> to_string |> String.split(".") |> List.last |> Macro.underscore}" |> String.to_atom

      def decode bytes do
        decode bytes, @codecs
      end

      defp decode _, [] do
        error @reason
      end

      defp decode bytes, [codec | codecs] do
        case_error codec.decode bytes do
          _ -> decode bytes, codecs
        end
      end

      def encode value do
        encode value, @codecs
      end

      defp encode _, [] do
        error @reason
      end

      defp encode value, [codec | codecs] do
        case_error codec.encode value do
          _ -> encode value, codecs
        end
      end
    end
  end
end
