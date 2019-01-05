defmodule MMS.EncodedString.WithCharset do
  use MMS.Composer, codecs: [MMS.Charset, MMS.Text]
end

defmodule MMS.EncodedString do
  use MMS.OneOf, codecs: [MMS.Text, MMS.EncodedString.WithCharset]

  def map({first, second}, fun) do
    first |> map(fun) ~> tuple(second)
  end

  def map(value, fun) do
    fun.(value) ~> ok
  end

  defp tuple first, second do
    {first, second}
  end
end
