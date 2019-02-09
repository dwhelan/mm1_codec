defmodule MMS.Composer2 do
  use MMS.Codec2

  def decode bytes, fs do
    bytes |> do_decode(fs, []) ~>> fn results -> error :nested, bytes, Enum.reverse(results) end
  end

  defp do_decode bytes, [], values do
    ok Enum.reverse(values), bytes
  end

  defp do_decode bytes, [f | fs], values do
    case bytes |> f.() do
      {:ok, {value, rest}} -> do_decode rest, fs, [value | values]
      error                -> error [error | values]
    end
  end

#  def encode [], _  do
#    ok <<>>
#  end
#
#  def encode values, codecs do
#    do_encode Enum.zip(values, codecs), []
#  end
#
#  defp do_encode [{value, codec} | list], value_bytes do
#    case value |> codec.encode do
#      {:ok, bytes} -> do_encode list, [bytes | value_bytes]
#      error        -> error
#    end
#  end
#
#  defp do_encode [], value_bytes do
#    bytes = value_bytes |> Enum.reverse |> Enum.join
#
#    case bytes |> byte_size |> ValueLength.encode do
#      {:ok, length_bytes} -> ok length_bytes <> bytes
#      error -> error
#    end
#  end

end

defmodule MMS.EncodedStringValue do
  @moduledoc """

  Encoded-string-value = Text-string | Value-length Char-set Text-string

  The Char-set values are registered by IANA as MIBEnum value.
  UTF-8 character-set encoding SHOULD be supported in Encoded-string-value.
  If the MMS Client uses UTF-8 character-set encoding, the Char-set parameter SHOULD be used to indicate its usage.

  Encoding according to [RFC2047] MAY be supported in the MMS Client and/or MMS Proxy-Relay.
  Encoding according to [RFC2047] SHOULD only be used without “Value-length Char-set” parameters.
  [RFC2047] encoding for UTF-8 character- set encoding MAY be supported in the MMS Client and/or MMS Proxy-Relay.
  """

  use MMS.Composer, codecs: [MMS.Charset, MMS.Text]
end

