defmodule MMS.SenderVisibility do
  use MMS.Lookup,
      values: [
        :hide,
        :show,
      ]
end
