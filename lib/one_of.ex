defmodule OkError.OneOf do
  import MMS.OkError

  # called via OneOf.call value, [modules], :decode

  defmacro one_of fname, modules do
    quote bind_quoted: [fname: fname, modules: modules] do
      def fname input do
        fname input, modules
      end

      defp fname input, [] do
        error()
      end

      defp fname input, [module | modules] do
        input |> module.fname ~>> fname(input, modules)
      end
    end
  end
end

defmodule MMS.OneOf do
  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      import MMS.OkError

      @codecs opts[:codecs] || []

      def decode bytes do
        decode bytes, @codecs
      end

      defp decode _, [] do
        error()
      end

      defp decode bytes, [codec | codecs] do
        case_error codec.decode bytes do
          _ -> decode bytes, codecs
        end
      end

      def encode value do
        encode :none, value, @codecs
      end

      defp encode _, _, [] do
        error()
      end

      defp encode _, value, [codec | codecs] do
        value |> codec.encode ~>> encode(value, codecs)
      end
    end
  end
end
