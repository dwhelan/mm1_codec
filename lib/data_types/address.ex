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

  def map {string, "IPv4"}, rest do
    case string |> to_charlist |> :inet.parse_ipv4_address do
      {:ok, ip} -> ok ip, rest
      _         -> error :invalid_ipv4_address
    end
  end

  def map {string, unknown}, rest do
    ok string <> "/TYPE=#{unknown}", rest
  end

  def encode {charset, value} do
    {charset, value} |> Composer.encode({Charset, String})
  end

  def encode value do
    value |> unmap |> EncodedString.encode
  end

  defp unmap(value) when is_ipv4(value) do
    (value |> :inet.ntoa |> to_string) <> "/TYPE=IPv4"
  end

  defp unmap(value) when is_binary(value) do
    cond do
      contains_type? value -> value
      is_email? value      -> value
      true                 -> value <> "/TYPE=PLMN"
    end
  end

  defp is_email? string do
    String.contains? string, "@"
  end

  defp contains_type? string do
    String.contains? string, "/TYPE"
  end
end
