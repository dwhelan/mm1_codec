defmodule MMS.ContentType.General do
  use MMS.Composer, codecs: [MMS.Media]

  def encode _ do
    error()
  end
end

defmodule MMS.ContentType do
  use MMS.OneOf, codecs: [MMS.ContentType.General, MMS.Media]
end
