defmodule MMS.ContentTypeValue do
  @moduledoc """
  8.4.2.24 Content type field

  The following rules are used to encode content type values.
  The short form of the Content-type-value MUST only be used when the well-known media is in the range of 0-127 or a text string.

  In all other cases the general form MUST be used.

  Content-type-value = Constrained-media | Content-general-form

  """
  import MMS.Either

  defcodec either: [MMS.ConstrainedMedia, MMS.ContentGeneralForm]
end
