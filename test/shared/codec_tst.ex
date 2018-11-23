defmodule MM1.CodecTest do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case
      alias MM1.Result

      test "base insufficient bytes" do
        module = result().module
        assert decode(<<>>) === %Result{module: module, value: {:err, :insufficient_bytes}, bytes: <<>>, rest: <<>>}
      end

      test "base decode" do
        assert decode(bytes()) === result()
      end

      test "base encode" do
        assert encode(result()) <> result().rest === bytes()
      end
    end
  end
end
