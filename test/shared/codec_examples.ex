defmodule MM1.CodecExamples do
  defmacro examples module, examples do
    quote bind_quoted: [module: module, examples: examples] do
      alias MM1.Result

      @module module

      test "insufficient bytes" do
        assert @module.decode(<<>>) === %Result{module: @module, err: :insufficient_bytes}
      end

      Enum.each(examples, fn {bytes, value} ->
        @bytes  bytes
        @value  value
        @result %Result{module: module, value: value, bytes: bytes}

        test "decode(#{inspect bytes}) == #{inspect value}" do
          assert @module.decode(@bytes <> "rest") === %Result{@result | rest: "rest"}
        end

        test "encode(#{inspect value}) == #{inspect bytes}" do
          assert @module.encode(@result) === @bytes
        end

        test "new(#{inspect value}) == %Result{value: #{inspect value}}" do
          assert @module.new(@value) === @result
        end
      end)
    end
  end

  defmacro decode_errors module, examples \\ [] do
    quote bind_quoted: [module: module, examples: examples] do
      alias MM1.Result

      @module module

      Enum.each(examples, fn {bytes, error, value} ->
        @bytes  bytes
        @result %Result{module: module, value: value, bytes: bytes, err: error}

        test "decode(#{inspect bytes}) == #{inspect error}" do
          assert @module.decode(@bytes <> "rest") === %Result{@result | rest: "rest"}
        end
      end)
    end
  end

  defmacro new_errors module, examples do
    quote bind_quoted: [module: module, examples: examples] do
      alias MM1.Result

      @module module

      Enum.each(examples, fn {value, error} ->
        @value  value
        @result %Result{module: module, value: value, err: error}

        test "new(#{inspect value}) == #{inspect @result}" do
          assert @module.new(@value) === @result
        end
      end)
    end
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @module opts[:module]
      alias MM1.Result

      test "insufficient bytes" do
        assert @module.decode(<<>>) === %Result{module: @module, err: :insufficient_bytes}
      end

      Enum.each(opts[:examples], fn {bytes, value} ->
        @bytes  bytes
        @value  value
        @result %Result{module: @module, value: value, bytes: bytes}

        test "decode(#{inspect bytes}) == #{inspect value}" do
          assert @module.decode(@bytes <> "rest") === %Result{@result | rest: "rest"}
        end

        test "encode(#{inspect value}) == #{inspect bytes}" do
          assert @module.encode(@result) === @bytes
        end

        test "new(#{inspect value}) == %Result{value: #{inspect value}}" do
          assert @module.new(@value) === @result
        end
      end)

      Enum.each(opts[:new_errors], fn {value, error} ->
        @value  value
        @result %Result{module: @module, value: value, err: error}

        test "new(#{inspect value}) == #{inspect @result}" do
          assert @module.new(@value) === @result
        end
      end)
    end
  end
end
