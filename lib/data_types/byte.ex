defmodule MMS.Byte do
  defmodule Decode do
    use Codec.Decode

    def decode <<byte, rest::binary>> do
      ok byte, rest
    end
  end

  defmodule Encode do
    use Codec.Encode

    def encode(byte) when is_byte(byte) do
      ok <<byte>>
    end

    def encode value do
      error :invalid_byte, value
    end
  end
end
