defmodule MM1.CodecExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @module         opts[:module]
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      new_errors    = opts[:new_errors]    || []

      alias MM1.Result

      test "insufficient bytes" do
        assert @module.decode(<<>>) === %Result{module: @module, err: :insufficient_bytes}
      end

      Enum.each(examples, fn {bytes, value} ->
        @bytes  bytes
        @value  value
        @result %Result{module: @module, value: value, bytes: bytes}

        test "decode(#{inspect bytes}) == #{inspect value}" do
          assert @module.decode(@bytes <> "rest") === %Result{@result | rest: "rest"}
        end

        test "encode(#{inspect value}) == #{inspect bytes}" do
          assert @module.encode(@result) === @bytes
        end

        test "new(#{inspect value}) == #{inspect bytes}" do
          assert @module.new(@value) === @result
        end
      end)

      Enum.each(decode_errors, fn {bytes, error, value} ->
        @bytes  bytes
        @result %Result{module: @module, value: value, bytes: bytes, err: error}

        test "decode(#{inspect bytes}) => Error: #{error}" do
          assert @module.decode(@bytes) === @result
        end
      end)

      Enum.each(new_errors, fn {value, error} ->
        @value  value
        @result %Result{module: @module, value: value, err: error}

        test "new(#{inspect value}) == #{error}" do
          assert @module.new(@value) === @result
        end
      end)
    end
  end
end
