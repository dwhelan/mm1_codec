defmodule MMS.ExtensionMediaTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.ExtensionMedia,

      examples: [
        {<<"\0">>, ""},
        {<<"string\0">>, "string"},
      ],

      decode_errors: [
        {<<1, 0>>,     {:extension_media, <<1, 0>>, [:text, :must_start_with_a_char]} },
        {<<"string">>, {:extension_media, "string", [:text, :missing_end_of_string]} },
      ],

      encode_errors: [
        {<<1>>, {:extension_media, <<1>>, [:text, :must_start_with_a_char]} },
        {"x\0",    {:extension_media, "x\0", [:text, :contains_end_of_string]} },
      ]
end
