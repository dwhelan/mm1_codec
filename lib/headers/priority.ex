defmodule MMS.Priority do
  use MMS.Lookup,
      values: [
        :low,
        :normal,
        :high,
      ]
end
