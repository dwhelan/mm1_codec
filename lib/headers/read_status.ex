defmodule MMS.ReadStatus do
  use MMS.Codec,
      values: [
        :read,
        :deleted,
      ]
end
