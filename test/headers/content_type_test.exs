defmodule MMS.ContentTypeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ContentType,
      examples: [
        { <<0x80>>,    "*/*"       }, # constrained media
        { <<1, 0x80>>, {"*/*", []} }, # content general form
      ],

      decode_errors: [
        {<<"x">>, :invalid_media},
      ]
end
