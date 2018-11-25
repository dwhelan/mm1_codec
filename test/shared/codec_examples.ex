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
        @result %Result{module: @module, value: @value, bytes: @bytes}

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
end
