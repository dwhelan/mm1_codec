defmodule MM1.Codecs.BaseExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      new_errors    = opts[:new_errors]    || []

      alias MM1.Result

      test "insufficient bytes" do
        assert @codec.decode(<<>>) === %Result{module: @codec, value: nil, err: :insufficient_bytes}
      end

      test "new(nil)" do
        assert @codec.new(nil) === %Result{module: @codec, err: :value_cannot_be_nil}
      end

      Enum.each(examples, fn {bytes, value} ->
        @bytes bytes; @value value; @error nil; @rest "rest"

        test "decode(#{inspect bytes}) === #{inspect value}" do
          assert_result @codec.decode(@bytes <> @rest), @value, @error, @bytes, @rest
        end

        test "encode(#{inspect value}) == #{inspect bytes}" do
          result = %Result{value: @value, bytes: @bytes}
          assert @codec.encode(result) === @bytes
        end

        test "new(#{inspect value})" do
          assert_result @codec.new(@value), @value, @error, @bytes, <<>>
        end

        test "#{@codec} #{inspect @bytes} |> decode |> encode === <bytes>" do
          assert @bytes |> @codec.decode |> @codec.encode === @bytes
        end

        test "#{@codec} #{inspect @value} |> new |> encode  === <bytes>" do
          assert @value |> @codec.new |> @codec.encode === @bytes
        end
      end)

      Enum.each(decode_errors, fn test_case ->
        {input, error, value, bytes} = if (tuple_size(test_case) == 3), do: Tuple.append(test_case, <<>>), else: test_case
        @input input; @error error; @value value; @bytes bytes

        rest_start  = byte_size(bytes)
        rest_length = byte_size(input) - rest_start
        @rest binary_part(@input, rest_start, rest_length)

        test "decode(#{inspect @input}) => Error: #{inspect @error}" do
          assert_result @codec.decode(@input), @value, @error, @bytes, @rest
        end
      end)

      Enum.each(new_errors, fn test_case ->
        {value, error, bytes} = if (tuple_size(test_case) == 2), do: Tuple.append(test_case, <<>>), else: test_case
        @value value; @error error; @bytes bytes; @rest <<>>

        test "new(#{inspect @value}) == #{inspect @error}" do
          assert_result @codec.new(@value), @value, @error, @bytes, @rest
        end
      end)

      def assert_result result, value, error, bytes, rest do
        assert result == %Result{module: @codec, value: value, err: error, bytes: bytes, rest: rest}
      end
    end
  end
end
