defmodule MMS.From do
  use MMS.Codec
  import OkError.Module

  alias MMS.{Composer, Short, Address}

  @address_present_token 0
  @insert_address_token  1

  def decode bytes do
    bytes |> Composer.decode([Short, Address]) <~> address
  end

  defp address({address, @address_present_token}), do: address
  defp address({@insert_address_token}),           do: :insert_address_token
  defp address(_),                                 do: module_error()

  def encode :insert_address_token do
    ok <<1, short @insert_address_token>>
  end

  def encode string do
    [@address_present_token, string] |> Composer.encode([Short, Address]) ~>> module_error
  end
end
