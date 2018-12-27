defmodule MMS.TextValue do
  use MMS.OneOf, codecs: [MMS.NoValue, MMS.QuotedString, MMS.Text]
end
