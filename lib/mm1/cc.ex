defmodule MM1.Cc do
  use MM1.Header,
      value: 0x82,
      codec: WAP.EncodedString
end

defmodule MM2.Cc do
  use MM2.Embed, codec: WAP2.EncodedString
end
