ExUnit.start exclude: [:skip],
             include: [
               # Uncomment the line below to only run tests with: # @tag :focus
               #     :focus], exclude: [:test
             ]


defmodule MMS.CodecTest do
  import OkError
  require MMS.Codec
  import MMS.DataTypes

  def s(short), do: short + 128
  def l(length), do: length
  def u(value),
      do: value
          |> MMS.UintvarInteger.encode
          |> elem(1)

  def invalid_uint32 do
    <<128>>
  end

  def invalid_short_length, do: max_short_length() + 1

  def assert_code_raise code do
    ExUnit.Assertions.assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end

  def date_time(seconds), do: DateTime.from_unix!(seconds)

  defmacro __using__ _ do
    quote do
      use ExUnit.Case

      import MMS.DataTypes
      import OkError
      import MMS.Codec
      import MMS.CodecTest
    end
  end

  defmodule Ok do
    def decode(<<byte, rest :: binary>>), do: ok {byte, rest}
    def encode(value), do: ok <<value>>
  end

  defmodule Error do
    def decode(bytes), do: error {:data_type, bytes, :reason}
    def encode(value), do: error {:data_type, value, :reason}
  end

  defmacro codec_examples list do
    quote do
      unquote(list)
      |> Enum.each(
           fn {name, bytes, value} ->
             @bytes bytes
             @value value

             test "decode #{name}" do
               assert decode(@bytes <> "rest") == ok @value, "rest"
             end

             test "encode #{name}" do
               assert encode(@value) == ok @bytes
             end
           end
         )
    end
  end

  defmacro decode_errors list do
    quote do
      unquote(list)
      |> Enum.each(
           fn {name, bytes, details} ->
             @bytes bytes
             @details details

             test "decode error: #{name}" do
               assert decode(@bytes) == error data_type(), @bytes, @details
             end
           end
         )
    end
  end

  defmacro encode_errors list do
    quote do
      unquote(list)
      |> Enum.each(
           fn {name, value, details} ->
             @value value
             @details details

             test "encode error: #{name}" do
               assert encode(@value) == error data_type(), @value, @details
             end
           end
         )
    end
  end
end
