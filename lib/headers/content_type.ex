defmodule MMS.ContentType do
  use MMS.Either, codecs: [MMS.ContentTypeGeneral, MMS.Media]
end

defmodule MMS.ContentTypeGeneral do
  use MMS.Composer, codecs: [MMS.Media]

  def encode _ do
    error()
  end
end

