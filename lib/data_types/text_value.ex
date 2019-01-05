defmodule MMS.TextValue do
  use MMS.Either, codecs: [MMS.NoValue, MMS.QuotedString, MMS.Text]
end
