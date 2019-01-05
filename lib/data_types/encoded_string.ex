defmodule MMS.EncodedString.WithCharset do
  use MMS.Composer, codecs: [MMS.Charset, MMS.Text]
end

defmodule MMS.EncodedString do
  use MMS.OneOf, codecs: [MMS.Text, MMS.EncodedString.WithCharset]

  def map({string, charset}, fun) do
    string |> map(fun) ~> tuple(charset)
  end

  def map(string, fun) do
    fun.(string) ~> ok
  end
end
