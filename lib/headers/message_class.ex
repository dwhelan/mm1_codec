defmodule MMS.XMmsMessageClass do
  defmodule ClassIdentifier do
    import MMS.As

    defcodec as: MMS.Octet, map: %{
      128 => :personal,
      129 => :advertisement,
      130 => :informational,
      131 => :auto
    }
  end

  import MMS.Either

  defcodec as: [ClassIdentifier, MMS.TokenText]
end
