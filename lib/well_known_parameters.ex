defmodule MMS.WellKnownParameters do
  # Based on WAP-230-WSP-20010705-a: Table 38. Well-Known Parameter Assignments
  #
  # The byte keys below are expressed as integers so they start at 128 (short-integer 0)

  use MMS.CodecMapper,
      map: %{
         128 => MMS.Q,
         129 => MMS.Charset,
      },
      error: :invalid_well_known_parameter
end
