defmodule MMS.UriValue do
  @moduledoc """
  7.2.3 X-Mms-Content-Location field

  Content-location-value = Uri-value

  Uri-value = Text-string

  URI value SHOULD be encoded per [RFC2616], but service user MAY use a different format.
  """
  import MMS.As

  defcodec as: MMS.TextString
end
