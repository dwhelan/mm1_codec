defmodule MMS.MessageClass do
  use MMS.Either, [MMS.KnownMessageClass, HTTP.Text]
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
