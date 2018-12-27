defmodule MMS.Version do
  use MMS.OneOf, codecs: [MMS.IntegerVersion, MMS.Text]
end
