defmodule MMS.PreviouslySentDate do
  use MMS.Composer,
      codecs: [MMS.Integer, MMS.Date]
end
