defmodule MMS.ContentType do
  use MMS.Either, [MMS.ContentTypeGeneral, MMS.Media]
end

defmodule MMS.ContentTypeGeneral do
  use MMS.Composer, codecs: [MMS.Media]
  import OkError.Module

  def encode _ do
    module_error()
  end
end

