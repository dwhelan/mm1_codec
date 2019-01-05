defmodule MMS.Media do
  use MMS.Codec, either: [MMS.KnownMedia, MMS.Text]
end
