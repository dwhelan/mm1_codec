defmodule MMS.EncodedString do
  use MMS.Codec, either: [MMS.Text, MMS.TextWithCharset]

  def map({string, charset}, fun) do
    string |> map(fun) ~> tuple(charset)
  end

  def map(string, fun) do
    fun.(string) ~> ok
  end
end

defmodule MMS.TextWithCharset do
  use MMS.Composer, codecs: [MMS.Charset, MMS.Text]
end

