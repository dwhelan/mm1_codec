defmodule MM1.Codecs2.TestExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      alias MM1.Result
      alias MM1.Codecs.Test

#      test "decode(nil) -> %Result{err: :must_be_a_binary}" do
#        assert @codec.decode(nil) === %Result{module: @codec, value: nil, err: :must_be_a_binary}
#      end
#
#      test "decode(not_a_binary) -> %Result{err: :must_be_a_binary}" do
#        assert @codec.decode(:not_a_binary) === %Result{module: @codec, value: nil, err: :must_be_a_binary}
#      end
#
#      test "decode(<<>>) -> %Result{err: :insufficient_bytes}" do
#        assert @codec.decode(<<>>) === %Result{module: @codec, value: nil, err: :insufficient_bytes}
#      end
#
#      test "encode(nil) -> :value_cannot_be_nil" do
#        assert @codec.encode(nil) === :value_cannot_be_nil
#      end
#
#      test "new(nil) -> %Result{err: :value_cannot_be_nil" do
#        assert @codec.new(nil) === %Result{module: @codec, err: :value_cannot_be_nil}
#      end

      Enum.each(examples, fn {bytes, value} ->
        @bytes bytes; @value value; @error nil; @rest "rest"

        test "decode(#{inspect bytes}) === #{Test.inspect value}" do
          assert @codec.decode(@bytes <> @rest) === {:ok, @value, @rest}
        end

        test "encode(#{Test.inspect value}) == #{inspect @bytes}" do
          assert @codec.encode(@value) === {:ok, @bytes}
        end

#        test "new(#{Test.inspect value})" do
#          assert @codec.new(@value) === {:ok, @bytes}
#        end
#
#        test "#{@codec} #{inspect @bytes} |> decode |> encode === <bytes>" do
#          assert @bytes |> @codec.decode |> @codec.encode === @bytes
#        end
#
#        test "#{@codec} #{Test.inspect @value} |> new |> encode  === <bytes>" do
#          assert @value |> @codec.new |> @codec.encode === @bytes
#        end
      end)

      Enum.each(decode_errors, fn test_case ->
        {input, error, value, bytes} = if (tuple_size(test_case) == 3), do: Tuple.append(test_case, <<>>), else: test_case
        @input input; @error error; @value value; @bytes bytes

        rest_start  = byte_size(bytes)
        rest_length = byte_size(input) - rest_start
        @rest binary_part(@input, rest_start, rest_length)

        test "decode(#{inspect @input}) => Error: #{inspect @error}" do
          assert @codec.decode(@input) === {:error, @error}
        end
      end)

      Enum.each(encode_errors, fn test_case ->
        {value, error, bytes} = if (tuple_size(test_case) == 2), do: Tuple.append(test_case, <<>>), else: test_case
        @value value; @error error; @bytes bytes; @rest <<>>

        test "encode(#{Test.inspect @value}) => {:err, #{inspect @error}}" do
          assert @codec.encode(@value) === {:error, @error}
        end
      end)

      def assert_result result, value, error, bytes, rest do
        assert is_atom @codec
        assert is_binary bytes
        assert is_binary rest
        if value != nil do
          assert result === {:ok, value, rest}
        else
          assert error != nil
          assert result === {:err, error, rest}
        end
#        assert value !== nil || error !== nil
#        assert result == %Result{module: @codec, value: value, err: error, bytes: bytes, rest: rest}
      end
      # {:ok, {module: :value}, rest}
      # {:err, error, value}
    end
  end
end
