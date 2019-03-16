defmodule MMS.ExtensionMedia do
  @moduledoc """
  8.4.2.1 Basic rules

  Extension-media = *TEXT End-of-string

  This encoding is used for media values, which have no well-known binary encoding.
  """

  alias MMS.Text

  defdelegate decode(bytes), to: Text
  defdelegate encode(value), to: Text
end
