defmodule MM1.Bcc do
  use MM1.BaseCodec
  alias MM1.Result

  def decode <<129, 0, rest::binary>> do
    return %Result{bytes: <<129, 0>>, value: 0, rest: rest}
  end
end
