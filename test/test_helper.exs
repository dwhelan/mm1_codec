ExUnit.start exclude: [:skip], include: [
  # Uncomment the line below to only run tests with: # @tag :focus
#     :focus], exclude: [:test
  ]

defmodule MM1.Codecs.Test do
  import Kernel, except: [inspect: 1]

  def inspect2 value do
    string = value |> Kernel.inspect |> String.slice(0..40)
  end
end
