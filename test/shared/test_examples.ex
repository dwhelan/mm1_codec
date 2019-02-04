defmodule MMS.TestExamples do
  def text(value) when is_binary(value) do
    if String.ends_with?(value, "\0") do
      String.slice(value, 0..-2) <> ~s(\0)
    else
      value
    end |> do_text
  end

  def text value do
    value |> do_text
  end

  defp do_text value do
    value |> Kernel.inspect |> String.slice(0..40)
  end

  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [opts: opts] do
      use MMS.Test2
      import MMS.TestExamples

      @codec opts[:codec] || __MODULE__

      Enum.each(opts[:examples] || [], fn {bytes, value} -> @bytes bytes; @value value
        test "decode #{text bytes} == {:ok, {#{text value}, <<>>}}" do
          assert @codec.decode(@bytes) == {:ok, {@value, <<>>}}
        end

        test "encode #{text value} == {:ok, #{text bytes}" do
          assert @codec.encode(@value) == {:ok, @bytes}
        end
      end)

      Enum.each(opts[:decode_errors] || [], fn test_case ->
        case test_case do
          {bytes, reason} -> @bytes bytes; @reason reason
            test "decode #{text bytes} => {:error, #{text reason}}" do
              assert @codec.decode(@bytes) == {:error, @reason}
            end

          bytes -> @bytes bytes
            test "decode #{text bytes} => {:error, _}" do
              assert {:error, _} = @codec.decode(@bytes)
            end
        end
      end)

      Enum.each(opts[:encode_errors] || [], fn test_case ->
          case test_case do
          {value, reason} -> @value value; @reason reason
            test "encode #{text value} => {:error, #{text reason}}" do
              assert @codec.encode(@value) == {:error, @reason}
            end

          value -> @value value
            test "encode #{text value} => {:error, _}" do
              assert {:error, _} = @codec.encode(@value)
            end
          end
      end)
    end
  end
end
