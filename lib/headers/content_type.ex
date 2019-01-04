defmodule MMS.ContentType.General do
  use MMS.Composer, codecs: [MMS.Media]
end

defmodule MMS.ContentType do
  use MMS.OneOf, codecs: [MMS.ContentType.General, MMS.Media]
end
