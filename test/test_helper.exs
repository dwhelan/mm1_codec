ExUnit.start exclude: [:skip], include: [
  # Uncomment the line below to only run tests with: # @tag :focus
#     :focus], exclude: [:test
  ]

defmodule MMS.Test do
  def s(short),  do: short + 128
  def l(length), do: length
end

