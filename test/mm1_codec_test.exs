defmodule Mm1.Result do
  defstruct value: nil, bytes: nil
end

defmodule Mm1CodecTest do
  use ExUnit.Case
  doctest Mm1Codec

  alias Mm1.Result

  test "octet" do
    assert %Result{bytes: <<0>>, value: 0} = Mm1Codec.decode(<<0>>)
  end
end
