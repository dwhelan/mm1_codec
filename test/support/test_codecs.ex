defmodule MMS.TestCodecs do
  alias MMS.TestCodecs.List

  import MMS.Module

  defmodule Ok do
    import OkError
    def decode(<<byte, rest :: binary>>), do: ok {byte, rest}
    def encode(value) when is_integer(value), do: ok <<value>>
    def encode(value), do: error {:data_type, value, :bad_type}
  end

  defmodule Error do
    import OkError
    def decode(bytes), do: error {:data_type, bytes, :reason}
    def encode(value), do: error {:data_type, value, :reason}
  end

  create List, MMS.List, []
end
