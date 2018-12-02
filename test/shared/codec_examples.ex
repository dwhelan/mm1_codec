defmodule MM1.Codecs.BaseExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]
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

        describe "decode(#{inspect bytes})" do
          test "module === #{@codec}" do
            assert @codec.decode(@bytes).module === @codec
          end

          test "value === #{inspect @value}" do
            assert @codec.decode(@bytes).value === @value
          end

          test "err === nil" do
            assert @codec.decode(@bytes).err === nil
          end

          test "consumes the right number of bytes" do
            assert @codec.decode(@bytes <> "rest").rest === "rest"
          end
        end

        @result %Result{module: @codec, value: value, bytes: bytes}


        test "encode(#{inspect value}) == #{inspect bytes}" do
          assert @codec.encode(@result) === @bytes
        end

        describe "new(#{inspect value})" do
          test "module === #{@codec}" do
            assert @codec.new(@value).module === @codec
          end

          test "value === #{@codec}" do
            assert @codec.new(@value).value === @value
          end

          test "err === nil" do
            assert @codec.new(@value).err === nil
          end

          test "rest is empty" do
            assert @codec.new(@value).rest === <<>>
          end
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
