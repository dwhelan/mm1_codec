defmodule MMS.ValueLength do
  use MMS.Either, [MMS.ShortLength, MMS.Uint32Length]
end

defmodule MMS.Uint32Length do
  @length_quote 31

  use MMS.Prefix, prefix: @length_quote, codec: MMS.Uint32
end
