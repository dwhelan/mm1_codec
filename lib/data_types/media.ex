defmodule MMS.Media do
  use MMS.Either, codecs: [MMS.KnownMedia, MMS.Text]
end
