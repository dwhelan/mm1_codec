defmodule MMS.MapExamples do
  def text value do
    value |> Kernel.inspect |> String.slice(0..40)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.TestExamples
      import MMS.OkError

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

      Enum.each(map_errors, fn {input, reason} ->
        @input  input
        @reason reason

        test "map #{text input} => {:error, #{text reason}}" do
          assert @mapper.map(@input) === {:error, @reason}
        end
      end)

      Enum.each(unmap_errors, fn {value, reason} ->
        @value  value
        @reason reason

        test "unmap #{text value} => {:error, #{text reason}}" do
          assert @mapper.unmap(@value) === {:error, @reason}
        end
      end)
    end
  end
end
