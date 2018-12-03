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
        @bytes bytes
        @value value

        test "decode(#{inspect bytes}) === #{inspect value}" do
          result = @codec.decode @bytes <> "rest"

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === nil
          assert result.bytes  === @bytes
          assert result.rest   === "rest"
        end

        test "encode(#{inspect value}) == #{inspect bytes}" do
          result = %Result{value: @value, bytes: @bytes}
          assert @codec.encode(result) === @bytes
        end

        test "new(#{inspect value})" do
          result = @codec.new @value

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === nil
          assert result.bytes  === @bytes
          assert result.rest   === <<>>
        end

        test "#{@codec} #{inspect @bytes} |> decode |> encode === <bytes>" do
          assert @bytes |> @codec.decode |> @codec.encode === @bytes
        end

        test "#{@codec} #{inspect @value} |> new |> encode  === <bytes>" do
          assert @value |> @codec.new |> @codec.encode === @bytes
        end
      end)

      Enum.each(decode_errors, fn test_case ->
        if (tuple_size(test_case) == 3) do
          {input, error, value} = test_case
          @input input
          @error error
          @value value
          @bytes <<>>
        else
          {input, error, value, bytes} = test_case
          @input input
          @error error
          @value value
          @bytes bytes
        end

        test "decode(#{inspect @input}) => Error: #{inspect @error}" do
          result = @codec.decode(@input)

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === @error
          assert result.bytes  === @bytes
          assert result.rest   === binary_part @input, byte_size(@bytes), byte_size(@input) - byte_size(@bytes)
        end
      end)

      Enum.each(new_errors, fn test_case ->
        if (tuple_size(test_case) == 2) do
          {value, error} = test_case
          @value value
          @error error
          @bytes <<>>
        else
          {value, error, bytes} = test_case
          @value value
          @error error
          @bytes bytes
        end

        test "new(#{inspect @value}) == #{inspect @error}" do
          result = @codec.new(@value)

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === @error
          assert result.bytes  === @bytes
          assert result.rest   === <<>>
        end
      end)
    end
  end
end
