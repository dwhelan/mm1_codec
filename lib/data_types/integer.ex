defmodule MMS.Integer do
  use MMS.Codec, either: [MMS.Short, MMS.Long]
end
