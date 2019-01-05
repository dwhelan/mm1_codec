defmodule MMS.EncodedString.WithCharset do
  use MMS.Composer, codecs: [MMS.Charset, MMS.Text]
end

defmodule MMS.EncodedString do
  use MMS.OneOf, codecs: [MMS.Text, MMS.EncodedString.WithCharset]

  def map({string, charset}, fun) do
    string |> map(fun) ~> MMS.OkError.Tuple.insert_at({charset})
  end

  def map(value, fun) do
    fun.(value) ~> ok
  end
end
