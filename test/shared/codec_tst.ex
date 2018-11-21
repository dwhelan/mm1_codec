defmodule MM1.CodecTest do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case
      alias MM1.Result

      describe "base decode" do
        test "valid bytes" do
          assert decode(bytes()) === result()
        end

        test "insufficient bytes" do
          module = result().module
          assert decode(<<>>) === %Result{module: module, value: {:err, :insufficient_bytes}, bytes: <<>>, rest: <<>>}
        end
      end

      describe "base encode" do
        test "valid result " do
          assert encode(result()) === bytes()
        end
      end
    end
  end
end
