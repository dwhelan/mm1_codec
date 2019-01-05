defmodule MMS.Integer do
  use MMS.Either, [MMS.Short, MMS.Long]
end
