defmodule MMS.Media do
  use MMS.OneOf, codecs: [MMS.WellKnownMedia, MMS.Text]
end
