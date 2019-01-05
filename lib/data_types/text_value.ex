defmodule MMS.TextValue do
  use MMS.Codec, either: [MMS.NoValue, MMS.QuotedString, MMS.Text]
end
