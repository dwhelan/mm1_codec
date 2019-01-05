defmodule MMS.ReadStatus do
  use MMS.Lookup,
      values: [
        :read,
        :deleted,
      ]
end
