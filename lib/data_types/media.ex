defmodule MMS.Media do
  use MMS.OneOf, codecs: [MMS.KnownMedia, MMS.Text]
end
