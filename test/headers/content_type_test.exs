defmodule MMS.ContentTypeTest do
  use ExUnit.Case
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.ContentType,
      examples: [
        { << s(0) >>,       "*/*"       }, # constrained media
        { << l(1), s(0) >>, {"*/*", []} }, # content general form
      ],

      decode_errors: [
        {<<"x">>, :invalid_media},
      ]
end
