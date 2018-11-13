defmodule Mm1.Result do
  defstruct name: "john"
end

defmodule Mm1CodecTest do
  use ExUnit.Case
  doctest Mm1Codec

  alias Mm1.Result

  test "octet" do
    assert %Result{} = Mm1Codec.decode(<<0>>)
  end
end
