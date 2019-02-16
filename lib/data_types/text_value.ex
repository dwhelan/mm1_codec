defmodule MMS.TextValue do
  use MMS.Either, [MMS.NoValue, MMS.QuotedString, HTTP.Text]
end
