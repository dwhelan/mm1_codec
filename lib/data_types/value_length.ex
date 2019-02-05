defmodule MMS.ValueLength do
  use MMS.Either, [MMS.ShortLength, MMS.Length]
end
