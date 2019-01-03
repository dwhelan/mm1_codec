defmodule MMS.MapExamples do
  def text value do
    value |> Kernel.inspect |> String.slice(0..40)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use MMS.Test
      import MMS.TestExamples

      @mapper        opts[:mapper]       || __MODULE__
      @reason        opts[:error]        || error_reason @mapper
      examples     = opts[:examples]     || []
      map_errors   = opts[:map_errors]   || []
      unmap_errors = opts[:unmap_errors] || []

      Enum.each(examples, fn {input, value} ->
        @input  input
        @value value

        test "map #{text input} === {:ok, {#{text value}, <<>>}}" do
          assert @mapper.map(@input) === {:ok, @value}
        end

        test "unmap #{text value} === {:ok, #{text input}" do
          assert @mapper.unmap(@value) === {:ok, @input}
        end
      end)

      Enum.each(map_errors, fn string ->
        @string  string

        test "map #{text string} => {:error, #{text @reason}}" do
          assert @mapper.map(@string) === {:error, @reason}
        end
      end)

      Enum.each(unmap_errors, fn value ->
        @value  value

        test "unmap #{text value} => {:error, #{text @reason}}" do
          assert @mapper.unmap(@value) === {:error, @reason}
        end
      end)
    end
  end
end
