defmodule MMS.ValueLength do
  @moduledoc """
  8.4.2.2 Length

  The following rules are used to encode length indicators.

  Value-length = Short-length | (Length-quote Length)
               = Short-length | Quoted-length

  Value length is used to indicate the length of the value to follow.
  """
  import MMS.Either

  defcodec either: [MMS.ShortLength, MMS.QuotedLength]
end
