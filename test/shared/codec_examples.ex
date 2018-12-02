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
        @bytes  bytes
        @value  value

        test "decode(#{inspect bytes}) === #{inspect value}" do
          result = @codec.decode @bytes

          assert result.module === @codec
          assert result.value  === @value
          assert result.err    === nil

          assert @codec.decode(@bytes <> "rest").rest === "rest"
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
          assert result.rest   === <<>>
        end

        test "#{@codec} #{inspect @bytes} |> decode |> encode === <bytes>" do
          assert @bytes |> @codec.decode |> @codec.encode === @bytes
        end

        test "#{@codec} #{inspect @value} |> new |> encode |> decode === new(#{inspect @value})" do
          result = @codec.new @value
          assert result |> @codec.encode |> @codec.decode === result
        end
      end)

      Enum.each(decode_errors, fn {bytes, error, value} ->
        @bytes  bytes
        @result %Result{module: @codec, value: value, bytes: bytes, err: error}

        test "decode(#{inspect bytes}) => Error: #{error}" do
          assert @codec.decode(@bytes) === @result
        end
      end)

      Enum.each(new_errors, fn {value, error} ->
        @value  value
        @result %Result{module: @codec, value: value, err: error}

        test "new(#{inspect value}) == #{error}" do
          assert @codec.new(@value) === @result
        end
      end)
    end
  end
end
