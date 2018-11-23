defmodule MM1.CodecExamples do
  defmacro examples module, examples do
    quote bind_quoted: [module: module, examples: examples] do
      alias MM1.Result

      @module module

      test "insufficient bytes" do
        assert @module.decode(<<>>) === %Result{module: @module, value: {:err, :insufficient_bytes}, bytes: <<>>, rest: <<>>}
      end

      Enum.each(examples, fn {name, bytes, value} ->
        @bytes  bytes
        @value  value
        @result %Result{module: @module, value: @value, bytes: @bytes}

        test "decode: #{name}" do
          assert @module.decode(@bytes <> "rest") === %Result{@result | rest: "rest"}
        end

        test "encode: #{name}" do
          assert @module.encode(@result) === @bytes
        end

        test "new: #{name}" do
          assert @module.new(@value) === @result
        end
      end)
    end
  end
end
