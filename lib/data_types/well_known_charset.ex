defmodule MMS.WellKnownCharset do
  @moduledoc """
  8.4.2.8 Accept charset Field

  Well-known-charset = Any-charset | Integer-value
  Both are encoded using values from Character Set Assignments table in Assigned Numbers.
  See https://www.iana.org/assignments/character-sets/character-sets.xhtml

  Any-charset = <Octet 128>
  Equivalent to the special RFC2616 charset value “*”
  """
  use MMS.Codec
  alias MMS.IntegerValue

  @map %{
       0 => :AnyCharset,
       3 => :ASCII,
       4 => :ISOLatin1,
       5 => :ISOLatin2,
       6 => :ISOLatin3,
       7 => :ISOLatin4,
       8 => :ISOLatinCyrillic,
       9 => :ISOLatinArabic,
      10 => :ISOLatinGreek,
      11 => :ISOLatinHebrew,
      12 => :ISOLatin5,
      13 => :ISOLatin6,
      14 => :ISOTextComm,
      15 => :HalfWidthKatakana,
      16 => :JISEncoding,
      17 => :ShiftJIS,
      18 => :EUCPkdFmtJapanese,
      19 => :EUCFixWidJapanese,
      20 => :ISO4UnitedKingdom,
      21 => :ISO11SwedishForNames,
      22 => :ISO15Italian,
      23 => :ISO17Spanish,
      24 => :ISO21German,
      25 => :ISO60DanishNorwegian,
      26 => :ISO69French,
      27 => :ISO10646UTF1,
      28 => :ISO646basic1983,
      29 => :INVARIANT,
      30 => :ISO2IntlRefVersion,
      31 => :NATSSEFI,
      32 => :NATSSEFIADD,
      33 => :NATSDANO,
      40 => :ISO2022JP2,
      34 => :NATSDANOADD,
      35 => :ISO10Swedish,
      36 => :KSC56011987,
      37 => :ISO2022KR,
      38 => :EUCKR,
      39 => :ISO2022JP,
      41 => :ISO13JISC6220jp,
      42 => :ISO14JISC6220ro,
      43 => :ISO16Portuguese,
      44 => :ISO18Greek7Old,
      45 => :ISO19LatinGreek,
      46 => :ISO25French,
      47 => :ISO27LatinGreek1,
      48 => :ISO5427Cyrillic,
      49 => :ISO42JISC62261978,
      50 => :ISO47BSViewdata,
      51 => :ISO49INIS,
      52 => :ISO50INIS8,
      53 => :ISO51INISCyrillic,
      54 => :ISO54271981,
      55 => :ISO5428Greek,
      56 => :ISO57GB1988,
      57 => :ISO58GB231280,
      58 => :ISO61Norwegian2,
      59 => :ISO70VideotexSupp1,
      60 => :ISO84Portuguese2,
      61 => :ISO85Spanish2,
      62 => :ISO86Hungarian,
      63 => :ISO87JISX0208,
      64 => :ISO88Greek7,
      65 => :ISO89ASMO449,
      66 => :ISO90,
      67 => :ISO91JISC62291984a,
      68 => :ISO92JISC62991984b,
      69 => :ISO93JIS62291984badd,
      70 => :ISO94JIS62291984hand,
      71 => :ISO95JIS62291984handad,
      72 => :ISO96JISC62291984kana,
      73 => :ISO2033,
      74 => :ISO99NAPLPS,
      75 => :ISO102T617bit,
      76 => :ISO103T618bit,
      77 => :ISO111ECMACyrillic,
      78 => :a71,
      79 => :a72,
      80 => :ISO123CSAZ24341985gr,
      81 => :ISO88596E,
      82 => :ISO88596I,
      83 => :ISO128T101G2,
      84 => :ISO88598E,
      85 => :ISO88598I,
      86 => :ISO139CSN369103,
      87 => :ISO141JUSIB1002,
      88 => :ISO143IECP271,
      89 => :ISO146Serbian,
      90 => :ISO147Macedonian,
      91 => :ISO150,
      92 => :ISO151Cuba,
      93 => :ISO6937Add,
      94 => :ISO153GOST1976874,
      95 => :ISO8859Supp,
      96 => :ISO10367Box,
      97 => :ISO158Lap,
      98 => :ISO159JISX02121990,
      99 => :ISO646Danish,
     100 => :USDK,
     101 => :DKUS,
     102 => :KSC5636,
     103 => :Unicode11UTF7,
     104 => :ISO2022CN,
     105 => :ISO2022CNEXT,
     106 => :UTF8,
     109 => :ISO885913,
     110 => :ISO885914,
     111 => :ISO885915,
     112 => :ISO885916,
     113 => :GBK,
     114 => :GB18030,
     115 => :OSDEBCDICDF0415,
     116 => :OSDEBCDICDF03IRV,
     117 => :OSDEBCDICDF041,
     118 => :ISO115481,
     119 => :KZ1048,
    1000 => :Unicode,
    1001 => :UCS4,
    1002 => :UnicodeASCII,
    1003 => :UnicodeLatin1,
    1004 => :UnicodeJapanese,
    1005 => :UnicodeIBM1261,
    1006 => :UnicodeIBM1268,
    1007 => :UnicodeIBM1276,
    1008 => :UnicodeIBM1264,
    1009 => :UnicodeIBM1265,
    1010 => :Unicode11,
    1011 => :SCSU,
    1012 => :UTF7,
    1013 => :UTF16BE,
    1014 => :UTF16LE,
    1015 => :UTF16,
    1016 => :CESU8,
    1017 => :UTF32,
    1018 => :UTF32BE,
    1019 => :UTF32LE,
    1020 => :BOCU1,
    2000 => :Windows30Latin1,
    2001 => :Windows31Latin1,
    2002 => :Windows31Latin2,
    2003 => :Windows31Latin5,
    2004 => :HPRoman8,
    2005 => :AdobeStandardEncod,
    2006 => :VenturaUS,
    2007 => :VenturaInternation,
    2008 => :DECMCS,
    2009 => :PC850Multilingual,
    2010 => :PCp852,
    2011 => :PC8CodePage437,
    2012 => :PC8DanishNorwegian,
    2013 => :PC862LatinHebrew,
    2014 => :PC8Turkish,
    2015 => :IBMSymbols,
    2016 => :IBMThai,
    2017 => :HPLegal,
    2018 => :HPPiFont,
    2019 => :HPMath8,
    2020 => :HPPSMath,
    2021 => :HPDesktop,
    2022 => :VenturaMath,
    2023 => :MicrosoftPublishin,
    2024 => :Windows31J,
    2025 => :GB2312,
    2026 => :Big5,
    2027 => :Macintosh,
    2028 => :IBM037,
    2029 => :IBM038,
    2030 => :IBM273,
    2031 => :IBM274,
    2032 => :IBM275,
    2033 => :IBM277,
    2034 => :IBM278,
    2035 => :IBM280,
    2036 => :IBM281,
    2037 => :IBM284,
    2038 => :IBM285,
    2039 => :IBM290,
    2040 => :IBM297,
    2041 => :IBM420,
    2042 => :IBM423,
    2043 => :IBM424,
    2044 => :IBM500,
    2045 => :IBM851,
    2046 => :IBM855,
    2047 => :IBM857,
    2048 => :IBM860,
    2049 => :IBM861,
    2050 => :IBM863,
    2051 => :IBM864,
    2052 => :IBM865,
    2053 => :IBM868,
    2054 => :IBM869,
    2055 => :IBM870,
    2056 => :IBM871,
    2057 => :IBM880,
    2058 => :IBM891,
    2059 => :IBM903,
    2060 => :IBBM904,
    2061 => :IBM905,
    2062 => :IBM918,
    2063 => :IBM1026,
    2064 => :IBMEBCDICATDE,
    2065 => :EBCDICATDEA,
    2066 => :EBCDICCAFR,
    2067 => :EBCDICDKNO,
    2068 => :EBCDICDKNOA,
    2069 => :EBCDICFISE,
    2070 => :EBCDICFISEA,
    2071 => :EBCDICFR,
    2072 => :EBCDICIT,
    2073 => :EBCDICPT,
    2074 => :EBCDICES,
    2075 => :EBCDICESA,
    2076 => :EBCDICESS,
    2077 => :EBCDICUK,
    2078 => :EBCDICUS,
    2079 => :Unknown8BiT,
    2080 => :Mnemonic,
    2081 => :Mnem,
    2082 => :VISCII,
    2083 => :VIQR,
    2084 => :KOI8R,
    2085 => :HZGB2312,
    2086 => :IBM866,
    2087 => :PC775Baltic,
    2088 => :KOI8U,
    2089 => :IBM00858,
    2090 => :IBM00924,
    2091 => :IBM01140,
    2092 => :IBM01141,
    2093 => :IBM01142,
    2094 => :IBM01143,
    2095 => :IBM01144,
    2096 => :IBM01145,
    2097 => :IBM01146,
    2098 => :IBM01147,
    2099 => :IBM01148,
    2100 => :IBM01149,
    2101 => :Big5HKSCS,
    2102 => :IBM1047,
    2103 => :PTCP154,
    2104 => :Amiga1251,
    2105 => :KOI7switched,
    2106 => :BRF,
    2107 => :TSCII,
    2108 => :CP51932,
    2109 => :windows874,
    2250 => :windows1250,
    2251 => :windows1251,
    2252 => :windows1252,
    2253 => :windows1253,
    2254 => :windows1254,
    2255 => :windows1255,
    2256 => :windows1256,
    2257 => :windows1257,
    2258 => :windows1258,
    2259 => :TIS620,
    2260 => :cp50220,
    3000 => :reserved,
  }

  def decode bytes do
    bytes
    |> decode_as(IntegerValue, @map)
  end

  def encode(charset) when is_atom(charset) do
    charset
    |> encode_as(IntegerValue, @map)
  end
end
