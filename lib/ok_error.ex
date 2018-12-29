defmodule MMS.OkError do

  def ok value, rest do
    {:ok, {value, rest}}
  end

  def ok value do
    {:ok, value}
  end

  def error codec, reason do
    {:error, {codec, reason}}
  end

  def error reason do
    {:error, reason}
  end

  def error_reason module do
    "invalid_#{module |> to_string |> String.split(".") |> List.last |> Macro.underscore}" |> String.to_atom
  end
#  defmacro _decode do: ok, else: error do
#
#    quote bind_quoted: [ok: ok, error: error] do
#      @ok ok
#      @error error
#
#      def decode bytes, codec do
#        case codec.decode bytes do
#          {:ok, {value, rest}} -> case {value, rest}, do: unquote(ok)
#          {:error, reason}     -> case reason, do: unquote(error)
#        end
#      end
#    end
#  end

  defmacro case_ok value, do: block do
    quote do
      case unquote value do
        {:ok, value} -> case value, do: unquote(block)
        error        -> error
      end
    end
  end

  defmacro case_error value, do: block do
    quote do
      case unquote value do
        {:error , reason} -> case reason, do: unquote(block)
        ok                -> ok
      end
    end
  end
end
