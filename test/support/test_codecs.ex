defmodule MMS.TestCodecs do
  alias MMS.TestCodecs.{List, ListOk, ListOkOk, ListOkError, ListErrorOk}

  import MMS.Module
  import OkError

  defmodule Ok do
    def decode(<<byte, rest :: binary>>), do: ok {byte, rest}
    def encode(value) when is_integer(value), do: ok <<value>>
    def encode(value), do: error {:data_type, value, :bad_type}
  end

  defmodule Error do
    def decode(bytes), do: error {:data_type, bytes, :reason}
    def encode(value), do: error {:data_type, value, :reason}
  end

  create List,         MMS.List, []
  create ListOk,       MMS.List, [Ok]
  create ListOkOk,     MMS.List, [Ok, Ok]
  create ListOkError,  MMS.List, [Ok, Error]
  create ListErrorOk,  MMS.List, [Error, Ok]
end
