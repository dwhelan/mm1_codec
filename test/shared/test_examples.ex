defmodule MMS.TestExamples do
  def text value do
    value |> Kernel.inspect |> String.slice(0..40)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use MMS.Test
      import MMS.TestExamples

      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      Enum.each(examples, fn {bytes, value} ->
        @bytes  bytes
        @value value

        test "decode #{text bytes} == {:ok, {#{text value}, <<>>}}" do
          assert @codec.decode(@bytes) == {:ok, {@value, <<>>}}
        end

        test "encode #{text value} == {:ok, #{text bytes}" do
          assert @codec.encode(@value) == {:ok, @bytes}
        end
      end)

      Enum.each(decode_errors, fn case ->
        case case do
          {bytes, reason} ->
            test "decode #{text bytes} => {:error, #{text reason}}" do
              assert @codec.decode(unquote bytes) == {:error, unquote reason}
            end

          bytes ->
            test "decode #{text bytes} => {:error, _}" do
              assert {:error, _} = @codec.decode(unquote bytes)
            end
        end
      end)

      Enum.each(encode_errors, fn {value, reason} ->
        @value  value
        @reason reason

        test "encode #{text value} => {:error, #{text reason}}" do
          assert @codec.encode(@value) == {:error, @reason}
        end
      end)

    end
  end
end
