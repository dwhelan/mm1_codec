defmodule MMS.PreviouslySentBy do
  use MMS.Composer, codecs: [MMS.Integer, MMS.Address2]
end
