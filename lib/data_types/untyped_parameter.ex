defmodule MMS.Tuple2 do
  defmacro defcodec opts do
    codecs = opts[:as]
    quote do
      use MMS.Codec
      import MMS.Tuple

      def decode bytes do
        bytes
        |> MMS.Tuple.decode(unquote codecs)
      end

      def encode {name, value} do
        {name, value}
        |> MMS.Tuple.encode(unquote codecs)
      end
    end
  end  

  defmacro __using__ (_) do
    quote do
      use MMS.Codec
      import MMS.Tuple2
    end
  end
end

defmodule MMS.UntypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Untyped-parameter = Token-text Untyped-value
  """
  use MMS.Tuple2

  defcodec as: {MMS.TokenText, MMS.UntypedValue}
end
