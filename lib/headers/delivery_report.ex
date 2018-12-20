defmodule MMS.DeliveryReport do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        :yes,
        :no,
      ],
      offset: 128
end
