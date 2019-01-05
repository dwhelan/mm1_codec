defmodule MMS.Media do
  use MMS.Either, [MMS.KnownMedia, MMS.Text]
end
