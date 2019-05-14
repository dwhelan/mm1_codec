defmodule MMS.ValueLength do
  @moduledoc """
  8.4.2.2 Length

  The following rules are used to encode length indicators.

  Value-length = Short-length | (Length-quote Length)
               = Short-length | Quoted-length

  Value length is used to indicate the length of the value to follow.
  """
  use MMS.Either
  import MMS.Length

  defcodec either: [MMS.ShortLength, MMS.QuotedLength]

  defmacro decode_as bytes, codec do
    decode_with_length bytes, codec, MMS.ValueLength
  end

  defmacro encode_as value, codec do
    encode_with_length value, codec, MMS.ValueLength
  end

end
