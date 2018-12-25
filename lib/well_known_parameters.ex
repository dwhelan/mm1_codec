defmodule MMS.WellKnownParameters do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  use MMS.CodecMapper,
      map: %{
         128 => MMS.Q,
         1 => MMS.Charset,
      },
      error: :invalid_well_known_parameter
end
