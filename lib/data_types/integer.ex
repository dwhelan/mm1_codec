defmodule MMS.Integer do
  use MMS.Either, codecs: [MMS.Short, MMS.Long]
end
