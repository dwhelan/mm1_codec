defmodule MMS.PreviouslySentDate do
  import MMS.Module
  import MMS.LengthLimiter

  alias MMS.{ValueLength, IntegerValue, DateValue}

  create MMS.PreviouslySentDate2, {IntegerValue, DateValue}

  defcodec length: ValueLength, as: MMS.PreviouslySentDate2
end
