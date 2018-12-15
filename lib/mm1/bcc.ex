defmodule MM1.Bcc do
  use MM1.Header,
      value: 0x81,
      codec: WAP.EncodedString
end

defmodule MM2.Bcc do
  use MM2.Embed, codec: WAP2.EncodedString
end
