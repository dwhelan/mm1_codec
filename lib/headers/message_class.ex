defmodule MMS.MessageClass do
  use MMS.Either, [MMS.KnownMessageClass, MMS.Text]
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
