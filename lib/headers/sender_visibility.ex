defmodule MMS.SenderVisibility do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.31 X-Mms-Sender-Visibility field
  """
  use MMS.As

  defcodec as: MMS.Octet, map: %{
    128 => :hide,
    129 => :show,
  }
end
