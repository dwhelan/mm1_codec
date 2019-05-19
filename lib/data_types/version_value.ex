defmodule MMS.VersionValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Version-value = Short-integer | Text-string

  The VersionInteger codec is responsible for interpreting the major and minor versions from a ShortInteger
  """
  import MMS.Either

  defcodec either: [MMS.VersionInteger, MMS.TextString]
end
