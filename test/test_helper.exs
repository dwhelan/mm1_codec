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

  defmacro decode_errors2 list do
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

  defmacro decode_errors list do
    quote do
      @data_type data_type()
      unquote(list)
      |> Enum.each(
           fn test_case ->
             name = elem(test_case, 0)
             @input elem(test_case, 1)
             @details if (tuple_size(test_case) > 2), do: elem(test_case, 2), else: nil

             IO.inspect details: @details
             test "#{name} decode error" do
               assert {:error, {@data_type, @input, _}} = decode(@input)
             end

             if @details do
               test "#{name} decode error data_type" do
                 {:error, {_, _, details}} = decode(@input)
                 cond do
                   is_atom(@details) -> assert details == @details
                   is_list(@details) ->
                     assert is_list(details), "Expected error details but it was not #{inspect details}"
                     @details
                     |> Enum.with_index()
                     |> Enum.each(
                          fn {detail, index} ->
                            assert detail == Enum.at(details, index)
                          end
                        )

                   true -> nil
                 end
               end
             end
           end
         )
    end
  end

  defmacro encode_errors list do
    quote do
      @data_type data_type()
      unquote(list)
      |> Enum.each(
           fn test_case ->
             name = elem(test_case, 0)
             @input elem(test_case, 1)
             @details if (tuple_size(test_case) > 2), do: elem(test_case, 2), else: nil

             IO.inspect details: @details
             test "#{name} encode error" do
               assert {:error, {@data_type, @input, _}} = encode(@input)
             end

             if @details do
               test "#{name} encode error data_type" do
                 {:error, {_, _, details}} = encode(@input)
                 cond do
                   is_atom(@details) -> assert details == @details
                   is_list(@details) ->
                     assert is_list(details), "Expected error details but it was not #{inspect details}"
                     @details
                     |> Enum.with_index()
                     |> Enum.each(
                          fn {detail, index} ->
                            assert detail == Enum.at(details, index)
                          end
                        )

                   true -> nil
                 end
               end
             end
           end
         )
    end
  end
end
