defmodule MMS.TextValue do
  use MMS.Either, [MMS.NoValue, MMS.QuotedString, MMS.Text]
end
