defmodule MMS.Integer do
  use MMS.OneOf, codecs: [MMS.Short, MMS.Long]
end
