defmodule MMS.Prefix do
  use MMS.Codec

  defmacro decode_with_prefix bytes, codec, prefix do
    quote bind_quoted: [bytes: bytes, codec: codec, prefix: prefix, data_type: data_type( __CALLER__.module)] do
      <<^prefix, rest::binary>> = bytes
      rest
      |> codec.decode
      ~>> fn details -> error data_type, bytes, nest_error(details) end
    end
  end

  defmacro encode_with_prefix value, codec, prefix do
    quote bind_quoted: [value: value, codec: codec, prefix: prefix, data_type: data_type( __CALLER__.module)] do
      value
      |> codec.encode
      ~> fn bytes -> <<prefix>> <> bytes end
      ~>> fn details -> error data_type, value, nest_error(details) end
    end
  end
end
