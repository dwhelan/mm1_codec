defmodule MMS.WellKnownParametersTestHelper do
  def parameter name, value do
    [{name, value}]
  end
end

defmodule MMS.WellKnownParametersTest do
  use ExUnit.Case
  import MMS.WellKnownParametersTestHelper
  alias MMS.WellKnownParameters

  time_zero = DateTime.from_unix!(0)

  use MMS.TestExamples,
      codec: WellKnownParameters,
      examples: [
        {<<128, 1>>, parameter(MMS.Q, "0.00")},
#        {<<0x82, "@",   0        >>, parameter(MMS.Cc,                    "@"         )},

        # Multiple headers
#        {<<0x81, "@", 0, 0x82, "@", 0>>, [{MMS.Bcc, "@"}, {MMS.Cc, "@"}]},
      ],

      encode_errors: [
#        { [{MMS.NotAHeader, "x"}], {MMS.NotAHeader,  :invalid_header}},
      ]

  test "decode should terminate when an unmapped byte is found" do
#    assert Headers.decode(<<0x80>>) == {:ok, {[], <<0x80>>}}
  end
end
