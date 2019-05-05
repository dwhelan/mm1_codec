ExUnit.start exclude: [:skip],
             include: [
               # Uncomment the line below to only run tests with: # @tag :focus
               #     :focus], exclude: [:test
             ]


defmodule MMS.CodecTest do
  import OkError
  require MMS.Codec
  import MMS.DataTypes
  import ExUnit.Assertions

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
    assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end

  def assert_function_clause_error  code do
    assert_raise FunctionClauseError, fn -> Code.eval_string(code) end
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
    quote location: :keep do
      test "decode empty binary" do
        assert decode(<<>>) == error {data_type(), <<>>, :no_bytes}
      end

      test "encode bad type" do
        bad_data = :c.pid(0,0,0)
        data_type = data_type()
        assert {:error, {data_type, bad_data, _}} = encode(bad_data)
      end

      def codec_example {name, bytes, value} do

      end

      unquote(list)
      |> Enum.each(
           fn {name, bytes, value} ->

             @value value
             if is_tuple(bytes) do
               @bytes elem(bytes, 0)
               @rest elem(bytes, 1)
             else
               @bytes bytes
               @rest "rest"
             end

             test "decode #{name}" do
               assert decode(@bytes <> @rest) == ok @value, @rest
             end

             test "encode #{name}" do
               assert encode(@value) == ok @bytes
             end
           end
         )
    end
  end

  defmacro decode_errors list do
    quote location: :keep do
      @data_type data_type() |> to_string |> String.replace_trailing("_test", "") |> String.to_atom

      test "no bytes" do
        assert decode(<<>>) == error @data_type, <<>>, :no_bytes
      end

      unquote(list)
      |> Enum.each(
           fn test_case ->
             name = elem(test_case, 0)
             @input elem(test_case, 1)
             @details if (tuple_size(test_case) > 2), do: elem(test_case, 2), else: nil

             test "#{name} decode error data_type = :#{@data_type}" do
               assert {:error, {@data_type, _, _}} = decode(@input)
             end

             test "#{name} decode error input" do
               assert {:error, {_, @input, _}} = decode(@input)
             end

             if @details do
               test "#{name} decode error details" do
                 {:error, {_, _, details}} = decode(@input)
                 if is_atom(@details) do
                   assert details == @details
                 end

                 if is_list(@details) do
                     assert is_list(details), "Expected error keyword list but it was not #{inspect details}"
                     @details
                     |> Enum.with_index()
                     |> Enum.each(
                          fn {detail, index} ->
                            assert detail == Enum.at(details, index)
                          end
                        )
                 end
               end
             end
           end
         )
    end
  end

  defmacro encode_errors list do
    quote location: :keep do
      @data_type data_type() |> to_string |> String.replace_trailing("_test", "") |> String.to_atom
      unquote(list)
      |> Enum.each(
           fn test_case ->
             name = elem(test_case, 0)
             @input elem(test_case, 1)
             @details if (tuple_size(test_case) > 2), do: elem(test_case, 2), else: nil

             test "#{name} encode error" do
               assert {:error, {@data_type, @input, _}} = encode(@input)
             end

             if @details do
               test "#{name} encode error data_type" do
                 {:error, {_, _, details}} = encode(@input)
                 if is_atom(@details) do
                   assert details == @details
                 end

                 if is_list(@details) do
                     assert is_list(details), "Expected error details but it was not #{inspect details}"
                     @details
                     |> Enum.with_index()
                     |> Enum.each(
                          fn {detail, index} ->
                            assert detail == Enum.at(details, index)
                          end
                        )
                 end
               end
             end
           end
         )
    end
  end
end
