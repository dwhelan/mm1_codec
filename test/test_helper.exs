ExUnit.start exclude: [:skip], include: [
  # Uncomment the line below to only run tests with: # @tag :focus
#     :focus], exclude: [:test
  ]


defmodule MMS.Test do
  def s(short),  do: short + 128
  def l(length), do: length

  def assert_code_error code do
    ExUnit.Assertions.assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      use ExUnit.Case

      import MMS.Test
      import OkError
      import MMS.DataTypes
    end
  end
end

