defmodule MMS.Priority do
  use MMS.Codec,
      values: [
        :low,
        :normal,
        :high,
      ]
end
