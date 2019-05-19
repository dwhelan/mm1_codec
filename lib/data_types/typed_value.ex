defmodule MMS.TypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-value = Compact-value | Text-value

  In addition to the expected type, there may be no value.

  If the value cannot be encoded using the expected type, it shall be encoded as text.
  """
  use MMS.Codec
  import MMS.As

  alias MMS.TextValue

  def decode bytes, codec do
    bytes
    |> codec.decode
    ~>> fn {data_type, _, details} ->
          bytes
          |> TextValue.decode
          ~>> fn {text_data_type, _, text_details} ->
                error bytes, [{data_type, details}, {text_data_type, text_details}]
              end
        end
  end

  def encode(value, codec) when is_atom(codec) do
    value
    |> codec.encode
    ~>> fn {data_type, _, details} ->
          value
          |> TextValue.encode
          ~>> fn {text_data_type, _, text_details} ->
                error value, [{data_type, details}, {text_data_type, text_details}]
              end
        end
  end
 end
