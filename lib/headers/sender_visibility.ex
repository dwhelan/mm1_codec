defmodule MMS.SenderVisibility do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        :hide,
        :show,
      ],
      offset: 128
end
