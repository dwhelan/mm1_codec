defmodule MMS.ContentGeneralForm do
  @moduledoc """
  8.4.2.24 Content type field

  Content-general-form = Value-length Media-type

  """
  import MMS.Length

  defcodec as: MMS.MediaType, length: MMS.ValueLength
end
