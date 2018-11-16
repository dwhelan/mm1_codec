defmodule MM1.Bcc do
  use MM1.BaseCodec

  def decode <<129, 0, rest::binary>> do
    return %MM1.Result{bytes: <<129, 0>>, value: 0, rest: rest}
  end
end
