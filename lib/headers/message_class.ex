defmodule MMS.MessageClass do
  use MMS.Codec, either: [MMS.KnownMessageClass, MMS.Text]
end

defmodule MMS.KnownMessageClass do
  use MMS.Lookup,
    values: [
      :personal,
      :advertisement,
      :informational,
      :auto
    ]
end
