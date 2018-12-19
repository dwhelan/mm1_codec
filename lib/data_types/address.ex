defmodule MMS.Address do
  import MMS.OkError
  import MMS.DataTypes

  alias MMS.EncodedString

  def decode bytes do
    case bytes |> EncodedString.decode do
      {:ok, {string, rest}} -> map_address string, rest
      error -> error
    end
  end

  def map_address string, rest do
    string |> split |> map(rest)
  end

  def split string do
    case string |> String.split("/TYPE=", parts: 2) do
      [string, type] -> {string, type}
      [string]       -> {string, :email}
    end
  end

  def map {string, :email}, rest do
    case is_email? string do
      true  -> ok string, rest
      false -> error :invalid_email
    end
  end

  def map {string, "PLMN"}, rest do
    case is_email? string do
      false -> ok string, rest
      true  -> error :invalid_phone_number
    end
  end

  defp is_email? string do
    String.contains? string, "@"
  end

  def encode(string) when is_binary(string) do
    string |> unmap |> EncodedString.encode
  end

  def encode {charset, string} do
    {charset, string} |> Composer.encode({Charset, String})
  end

  defp unmap string do
    cond do
      is_email? string -> string
      true -> string <> "/TYPE=PLMN"
    end
  end
end
