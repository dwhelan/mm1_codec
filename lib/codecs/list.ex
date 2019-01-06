defmodule MMS.List do
  use MMS.Codec

  def decode bytes, codecs do
    codecs |> Enum.reduce(ok([], bytes), &do_decode/2) <~> Enum.reverse
  end

  defp do_decode codec, {:ok, {values, bytes}} do
    bytes |> codec.decode <~> insert(values)
  end

  defp insert value, list do
    [value | list]
  end

  defmacro __using__ opts \\ [] do
    check_types opts[:codecs]

    quote do
      import OkError

      def decode bytes do
        ok [0, "x"], <<>>
      end

      def encode value do
        ok << 128, "x\0" >>
      end
    end
  end

  defp check_types codecs do
    if Keyword.keyword?(codecs) do
      raise ArgumentError, """
      "use MMS.List" expects to be passed a list of codecs. For example:


        defmodule MyCodec do
          use MMS.List, codecs: [MMS.Byte. MMS.Short]
        end
      """
    end
  end
end
