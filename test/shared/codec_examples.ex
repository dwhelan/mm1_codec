defmodule MM1.Codecs.BaseExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      decode_errors2 = opts[:decode_errors2] || []
      new_errors    = opts[:new_errors]    || []
      new_errors2    = opts[:new_errors2]    || []

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

      Enum.each(decode_errors, fn {bytes, error, value} ->
        @bytes bytes
        @error error
        @value value

        test "decode(#{inspect bytes}) => Error: #{inspect error}" do
          result = @codec.decode(@bytes)

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === @error
          assert result.bytes <> result.rest   === @bytes
        end
      end)

      Enum.each(decode_errors2, fn {input_bytes, error, value, bytes} ->
        @input_bytes input_bytes
        @error error
        @value value
        @bytes bytes

        test "decode(#{inspect input_bytes}) => Error: #{inspect error}" do
          result = @codec.decode(@input_bytes)

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === @error
          assert result.bytes  === @bytes
          assert result.rest   === binary_part @input_bytes, byte_size(@bytes), byte_size(@input_bytes) - byte_size(@bytes)
        end
      end)

      Enum.each(new_errors, fn {value, error} ->
        @value value
        @error error

        test "new(#{inspect value}) == #{inspect error}" do
          result = @codec.new(@value)

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === @error
          assert result.rest   === <<>>
        end
      end)

      Enum.each(new_errors2, fn {value, error, bytes} ->
        @value value
        @error error
        @bytes bytes

        test "new(#{inspect value}) == #{inspect error}" do
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
