defmodule MMS.EncodedString.WithCharset do
  use MMS.Composer, codecs: [MMS.Charset, MMS.Text]
end

defmodule MMS.EncodedString do
  use MMS.OneOf, codecs: [MMS.Text, MMS.EncodedString.WithCharset]

  def map(string, fun) when is_binary(string) and is_function(fun) do
    fun.(string) ~> ok
  end

  def map({string, charset}, fun) when is_binary(string) and is_function(fun) do
    string |> map(fun) ~> tuple(charset)
  end

  defp tuple string, charset do
    {string, charset}
  end
end
