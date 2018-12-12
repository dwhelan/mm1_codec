defmodule WAP.CharSets do
  @moduledoc """
    Specification: (IANA-CHARSET-MIB DEFINITIONS)[https://www.iana.org/assignments/character-sets/character-sets.xhtml]
  """

  @char_sets %{
    other:                       1,
    unknown:                     2,
    csASCII:                     3,
    csISOLatin1:                 4,
    csISOLatin2:                 5,
    csISOLatin3:                 6,
    csISOLatin4:                 7,
    csISOLatinCyrillic:          8,
    csISOLatinArabic:            9,
    csISOLatinGreek:            10,
    csISOLatinHebrew:           11,
    csISOLatin5:                12,
    csISOLatin6:                13,
    csISOTextComm:              14,
    csHalfWidthKatakana:        15,
    csJISEncoding:              16,
    csShiftJIS:                 17,
    csEUCPkdFmtJapanese:        18,
    csEUCFixWidJapanese:        19,
    csISO4UnitedKingdom:        20,
    csISO11SwedishForNames:     21,
    csISO15Italian:             22,
    csISO17Spanish:             23,
    csISO21German:              24,
    csISO60DanishNorwegian:     25,
    csISO69French:              26,
    csISO10646UTF1:             27,
    csISO646basic1983:          28,
    csINVARIANT:                29,
    csISO2IntlRefVersion:       30,
    csNATSSEFI:                 31,
    csNATSSEFIADD:              32,
    csNATSDANO:                 33,
    csISO2022JP2:               40,
    csNATSDANOADD:              34,
    csISO10Swedish:             35,
    csKSC56011987:              36,
    csISO2022KR:                37,
    csEUCKR:                    38,
    csISO2022JP:                39,
    csISO13JISC6220jp:          41,
    csISO14JISC6220ro:          42,
    csISO16Portuguese:          43,
    csISO18Greek7Old:           44,
    csISO19LatinGreek:          45,
    csISO25French:              46,
    csISO27LatinGreek1:         47,
    csISO5427Cyrillic:          48,
    csISO42JISC62261978:        49,
    csISO47BSViewdata:          50,
    csISO49INIS:                51,
    csISO50INIS8:               52,
    csISO51INISCyrillic:        53,
    csISO54271981:              54,
    csISO5428Greek:             55,
    csISO57GB1988:              56,
    csISO58GB231280:            57,
    csISO61Norwegian2:          58,
    csISO70VideotexSupp1:       59,
    csISO84Portuguese2:         60,
    csISO85Spanish2:            61,
    csISO86Hungarian:           62,
    csISO87JISX0208:            63,
    csISO88Greek7:              64,
    csISO89ASMO449:             65,
    csISO90:                    66,
    csISO91JISC62291984a:       67,
    csISO92JISC62991984b:       68,
    csISO93JIS62291984badd:     69,
    csISO94JIS62291984hand:     70,
    csISO95JIS62291984handadd:  71,
    csISO96JISC62291984kana:    72,
    csISO2033:                  73,
    csISO99NAPLPS:              74,
    csISO102T617bit:            75,
    csISO103T618bit:            76,
    csISO111ECMACyrillic:       77,
    csa71:                      78,
    csa72:                      79,
    csISO123CSAZ24341985gr:     80,
    csISO88596E:                81,
    csISO88596I:                82,
    csISO128T101G2:             83,
    csISO88598E:                84,
    csISO88598I:                85,
    csISO139CSN369103:          86,
    csISO141JUSIB1002:          87,
    csISO143IECP271:            88,
    csISO146Serbian:            89,
    csISO147Macedonian:         90,
    csISO150:                   91,
    csISO151Cuba:               92,
    csISO6937Add:               93,
    csISO153GOST1976874:        94,
    csISO8859Supp:              95,
    csISO10367Box:              96,
    csISO158Lap:                97,
    csISO159JISX02121990:       98,
    csISO646Danish:             99,
    csUSDK:                    100,
    csDKUS:                    101,
    csKSC5636:                 102,
    csUnicode11UTF7:           103,
    csISO2022CN:               104,
    csISO2022CNEXT:            105,
    csUTF8:                    106,
    csISO885913:               109,
    csISO885914:               110,
    csISO885915:               111,
    csISO885916:               112,
    csGBK:                     113,
    csGB18030:                 114,
    csOSDEBCDICDF0415:         115,
    csOSDEBCDICDF03IRV:        116,
    csOSDEBCDICDF041:          117,
    csISO115481:               118,
    csKZ1048:                  119,
    csUnicode:                1000,
    csUCS4:                   1001,
    csUnicodeASCII:           1002,
    csUnicodeLatin1:          1003,
    csUnicodeJapanese:        1004,
    csUnicodeIBM1261:         1005,
    csUnicodeIBM1268:         1006,
    csUnicodeIBM1276:         1007,
    csUnicodeIBM1264:         1008,
    csUnicodeIBM1265:         1009,
    csUnicode11:              1010,
    csSCSU:                   1011,
    csUTF7:                   1012,
    csUTF16BE:                1013,
    csUTF16LE:                1014,
    csUTF16:                  1015,
    csCESU8:                  1016,
    csUTF32:                  1017,
    csUTF32BE:                1018,
    csUTF32LE:                1019,
    csBOCU1:                  1020,
    csWindows30Latin1:        2000,
    csWindows31Latin1:        2001,
    csWindows31Latin2:        2002,
    csWindows31Latin5:        2003,
    csHPRoman8:               2004,
    csAdobeStandardEncoding:  2005,
    csVenturaUS:              2006,
    csVenturaInternational:   2007,
    csDECMCS:                 2008,
    csPC850Multilingual:      2009,
    csPCp852:                 2010,
    csPC8CodePage437:         2011,
    csPC8DanishNorwegian:     2012,
    csPC862LatinHebrew:       2013,
    csPC8Turkish:             2014,
    csIBMSymbols:             2015,
    csIBMThai:                2016,
    csHPLegal:                2017,
    csHPPiFont:               2018,
    csHPMath8:                2019,
    csHPPSMath:               2020,
    csHPDesktop:              2021,
    csVenturaMath:            2022,
    csMicrosoftPublishing:    2023,
    csWindows31J:             2024,
    csGB2312:                 2025,
    csBig5:                   2026,
    csMacintosh:              2027,
    csIBM037:                 2028,
    csIBM038:                 2029,
    csIBM273:                 2030,
    csIBM274:                 2031,
    csIBM275:                 2032,
    csIBM277:                 2033,
    csIBM278:                 2034,
    csIBM280:                 2035,
    csIBM281:                 2036,
    csIBM284:                 2037,
    csIBM285:                 2038,
    csIBM290:                 2039,
    csIBM297:                 2040,
    csIBM420:                 2041,
    csIBM423:                 2042,
    csIBM424:                 2043,
    csIBM500:                 2044,
    csIBM851:                 2045,
    csIBM855:                 2046,
    csIBM857:                 2047,
    csIBM860:                 2048,
    csIBM861:                 2049,
    csIBM863:                 2050,
    csIBM864:                 2051,
    csIBM865:                 2052,
    csIBM868:                 2053,
    csIBM869:                 2054,
    csIBM870:                 2055,
    csIBM871:                 2056,
    csIBM880:                 2057,
    csIBM891:                 2058,
    csIBM903:                 2059,
    csIBBM904:                2060,
    csIBM905:                 2061,
    csIBM918:                 2062,
    csIBM1026:                2063,
    csIBMEBCDICATDE:          2064,
    csEBCDICATDEA:            2065,
    csEBCDICCAFR:             2066,
    csEBCDICDKNO:             2067,
    csEBCDICDKNOA:            2068,
    csEBCDICFISE:             2069,
    csEBCDICFISEA:            2070,
    csEBCDICFR:               2071,
    csEBCDICIT:               2072,
    csEBCDICPT:               2073,
    csEBCDICES:               2074,
    csEBCDICESA:              2075,
    csEBCDICESS:              2076,
    csEBCDICUK:               2077,
    csEBCDICUS:               2078,
    csUnknown8BiT:            2079,
    csMnemonic:               2080,
    csMnem:                   2081,
    csVISCII:                 2082,
    csVIQR:                   2083,
    csKOI8R:                  2084,
    csHZGB2312:               2085,
    csIBM866:                 2086,
    csPC775Baltic:            2087,
    csKOI8U:                  2088,
    csIBM00858:               2089,
    csIBM00924:               2090,
    csIBM01140:               2091,
    csIBM01141:               2092,
    csIBM01142:               2093,
    csIBM01143:               2094,
    csIBM01144:               2095,
    csIBM01145:               2096,
    csIBM01146:               2097,
    csIBM01147:               2098,
    csIBM01148:               2099,
    csIBM01149:               2100,
    csBig5HKSCS:              2101,
    csIBM1047:                2102,
    csPTCP154:                2103,
    csAmiga1251:              2104,
    csKOI7switched:           2105,
    csBRF:                    2106,
    csTSCII:                  2107,
    csCP51932:                2108,
    cswindows874:             2109,
    cswindows1250:            2250,
    cswindows1251:            2251,
    cswindows1252:            2252,
    cswindows1253:            2253,
    cswindows1254:            2254,
    cswindows1255:            2255,
    cswindows1256:            2256,
    cswindows1257:            2257,
    cswindows1258:            2258,
    csTIS620:                 2259,
    cs50220:                  2260,
    reserved:                 3000,
  }

  @char_sets_by_code Enum.reduce(@char_sets, %{}, fn {k,v}, map -> Map.put(map, v, k) end)

  alias MM1.Result

  def map %Result{} = result do
    %Result{result | value: map(result.value)}
  end

  def map code do
    @char_sets_by_code[code] || code
  end

  def unmap %Result{} = result do
    %Result{result | value: unmap(result.value)}
  end

  def unmap atom do
   @char_sets[atom] || atom
  end
end

defmodule WAP2.CharSets do
  @moduledoc """
    Specification: (IANA-CHARSET-MIB DEFINITIONS)[https://www.iana.org/assignments/character-sets/character-sets.xhtml]
  """

  @char_sets %{
       1 => :other,
       2 => :unknown,
       3 => :csASCII,
       4 => :csISOLatin1,
       5 => :csISOLatin2,
       6 => :csISOLatin3,
       7 => :csISOLatin4,
       8 => :csISOLatinCyrillic,
       9 => :csISOLatinArabic,
      10 => :csISOLatinGreek,
      11 => :csISOLatinHebrew,
      12 => :csISOLatin5,
      13 => :csISOLatin6,
      14 => :csISOTextComm,
      15 => :csHalfWidthKatakana,
      16 => :csJISEncoding,
      17 => :csShiftJIS,
      18 => :csEUCPkdFmtJapanese,
      19 => :csEUCFixWidJapanese,
      20 => :csISO4UnitedKingdom,
      21 => :csISO11SwedishForNames,
      22 => :csISO15Italian,
      23 => :csISO17Spanish,
      24 => :csISO21German,
      25 => :csISO60DanishNorwegian,
      26 => :csISO69French,
      27 => :csISO10646UTF1,
      28 => :csISO646basic1983,
      29 => :csINVARIANT,
      30 => :csISO2IntlRefVersion,
      31 => :csNATSSEFI,
      32 => :csNATSSEFIADD,
      33 => :csNATSDANO,
      40 => :csISO2022JP2,
      34 => :csNATSDANOADD,
      35 => :csISO10Swedish,
      36 => :csKSC56011987,
      37 => :csISO2022KR,
      38 => :csEUCKR,
      39 => :csISO2022JP,
      41 => :csISO13JISC6220jp,
      42 => :csISO14JISC6220ro,
      43 => :csISO16Portuguese,
      44 => :csISO18Greek7Old,
      45 => :csISO19LatinGreek,
      46 => :csISO25French,
      47 => :csISO27LatinGreek1,
      48 => :csISO5427Cyrillic,
      49 => :csISO42JISC62261978,
      50 => :csISO47BSViewdata,
      51 => :csISO49INIS,
      52 => :csISO50INIS8,
      53 => :csISO51INISCyrillic,
      54 => :csISO54271981,
      55 => :csISO5428Greek,
      56 => :csISO57GB1988,
      57 => :csISO58GB231280,
      58 => :csISO61Norwegian2,
      59 => :csISO70VideotexSupp1,
      60 => :csISO84Portuguese2,
      61 => :csISO85Spanish2,
      62 => :csISO86Hungarian,
      63 => :csISO87JISX0208,
      64 => :csISO88Greek7,
      65 => :csISO89ASMO449,
      66 => :csISO90,
      67 => :csISO91JISC62291984a,
      68 => :csISO92JISC62991984b,
      69 => :csISO93JIS62291984badd,
      70 => :csISO94JIS62291984hand,
      71 => :csISO95JIS62291984handad,
      72 => :csISO96JISC62291984kana,
      73 => :csISO2033,
      74 => :csISO99NAPLPS,
      75 => :csISO102T617bit,
      76 => :csISO103T618bit,
      77 => :csISO111ECMACyrillic,
      78 => :csa71,
      79 => :csa72,
      80 => :csISO123CSAZ24341985gr,
      81 => :csISO88596E,
      82 => :csISO88596I,
      83 => :csISO128T101G2,
      84 => :csISO88598E,
      85 => :csISO88598I,
      86 => :csISO139CSN369103,
      87 => :csISO141JUSIB1002,
      88 => :csISO143IECP271,
      89 => :csISO146Serbian,
      90 => :csISO147Macedonian,
      91 => :csISO150,
      92 => :csISO151Cuba,
      93 => :csISO6937Add,
      94 => :csISO153GOST1976874,
      95 => :csISO8859Supp,
      96 => :csISO10367Box,
      97 => :csISO158Lap,
      98 => :csISO159JISX02121990,
      99 => :csISO646Danish,
     100 => :csUSDK,
     101 => :csDKUS,
     102 => :csKSC5636,
     103 => :csUnicode11UTF7,
     104 => :csISO2022CN,
     105 => :csISO2022CNEXT,
     106 => :csUTF8,
     109 => :csISO885913,
     110 => :csISO885914,
     111 => :csISO885915,
     112 => :csISO885916,
     113 => :csGBK,
     114 => :csGB18030,
     115 => :csOSDEBCDICDF0415,
     116 => :csOSDEBCDICDF03IRV,
     117 => :csOSDEBCDICDF041,
     118 => :csISO115481,
     119 => :csKZ1048,
    1000 => :csUnicode,
    1001 => :csUCS4,
    1002 => :csUnicodeASCII,
    1003 => :csUnicodeLatin1,
    1004 => :csUnicodeJapanese,
    1005 => :csUnicodeIBM1261,
    1006 => :csUnicodeIBM1268,
    1007 => :csUnicodeIBM1276,
    1008 => :csUnicodeIBM1264,
    1009 => :csUnicodeIBM1265,
    1010 => :csUnicode11,
    1011 => :csSCSU,
    1012 => :csUTF7,
    1013 => :csUTF16BE,
    1014 => :csUTF16LE,
    1015 => :csUTF16,
    1016 => :csCESU8,
    1017 => :csUTF32,
    1018 => :csUTF32BE,
    1019 => :csUTF32LE,
    1020 => :csBOCU1,
    2000 => :csWindows30Latin1,
    2001 => :csWindows31Latin1,
    2002 => :csWindows31Latin2,
    2003 => :csWindows31Latin5,
    2004 => :csHPRoman8,
    2005 => :csAdobeStandardEncod,
    2006 => :csVenturaUS,
    2007 => :csVenturaInternation,
    2008 => :csDECMCS,
    2009 => :csPC850Multilingual,
    2010 => :csPCp852,
    2011 => :csPC8CodePage437,
    2012 => :csPC8DanishNorwegian,
    2013 => :csPC862LatinHebrew,
    2014 => :csPC8Turkish,
    2015 => :csIBMSymbols,
    2016 => :csIBMThai,
    2017 => :csHPLegal,
    2018 => :csHPPiFont,
    2019 => :csHPMath8,
    2020 => :csHPPSMath,
    2021 => :csHPDesktop,
    2022 => :csVenturaMath,
    2023 => :csMicrosoftPublishin,
    2024 => :csWindows31J,
    2025 => :csGB2312,
    2026 => :csBig5,
    2027 => :csMacintosh,
    2028 => :csIBM037,
    2029 => :csIBM038,
    2030 => :csIBM273,
    2031 => :csIBM274,
    2032 => :csIBM275,
    2033 => :csIBM277,
    2034 => :csIBM278,
    2035 => :csIBM280,
    2036 => :csIBM281,
    2037 => :csIBM284,
    2038 => :csIBM285,
    2039 => :csIBM290,
    2040 => :csIBM297,
    2041 => :csIBM420,
    2042 => :csIBM423,
    2043 => :csIBM424,
    2044 => :csIBM500,
    2045 => :csIBM851,
    2046 => :csIBM855,
    2047 => :csIBM857,
    2048 => :csIBM860,
    2049 => :csIBM861,
    2050 => :csIBM863,
    2051 => :csIBM864,
    2052 => :csIBM865,
    2053 => :csIBM868,
    2054 => :csIBM869,
    2055 => :csIBM870,
    2056 => :csIBM871,
    2057 => :csIBM880,
    2058 => :csIBM891,
    2059 => :csIBM903,
    2060 => :csIBBM904,
    2061 => :csIBM905,
    2062 => :csIBM918,
    2063 => :csIBM1026,
    2064 => :csIBMEBCDICATDE,
    2065 => :csEBCDICATDEA,
    2066 => :csEBCDICCAFR,
    2067 => :csEBCDICDKNO,
    2068 => :csEBCDICDKNOA,
    2069 => :csEBCDICFISE,
    2070 => :csEBCDICFISEA,
    2071 => :csEBCDICFR,
    2072 => :csEBCDICIT,
    2073 => :csEBCDICPT,
    2074 => :csEBCDICES,
    2075 => :csEBCDICESA,
    2076 => :csEBCDICESS,
    2077 => :csEBCDICUK,
    2078 => :csEBCDICUS,
    2079 => :csUnknown8BiT,
    2080 => :csMnemonic,
    2081 => :csMnem,
    2082 => :csVISCII,
    2083 => :csVIQR,
    2084 => :csKOI8R,
    2085 => :csHZGB2312,
    2086 => :csIBM866,
    2087 => :csPC775Baltic,
    2088 => :csKOI8U,
    2089 => :csIBM00858,
    2090 => :csIBM00924,
    2091 => :csIBM01140,
    2092 => :csIBM01141,
    2093 => :csIBM01142,
    2094 => :csIBM01143,
    2095 => :csIBM01144,
    2096 => :csIBM01145,
    2097 => :csIBM01146,
    2098 => :csIBM01147,
    2099 => :csIBM01148,
    2100 => :csIBM01149,
    2101 => :csBig5HKSCS,
    2102 => :csIBM1047,
    2103 => :csPTCP154,
    2104 => :csAmiga1251,
    2105 => :csKOI7switched,
    2106 => :csBRF,
    2107 => :csTSCII,
    2108 => :csCP51932,
    2109 => :cswindows874,
    2250 => :cswindows1250,
    2251 => :cswindows1251,
    2252 => :cswindows1252,
    2253 => :cswindows1253,
    2254 => :cswindows1254,
    2255 => :cswindows1255,
    2256 => :cswindows1256,
    2257 => :cswindows1257,
    2258 => :cswindows1258,
    2259 => :csTIS620,
    2260 => :cs50220,
    3000 => :reserved,
  }

  @char_sets_by_code Enum.reduce(@char_sets, %{}, fn {k,v}, map -> Map.put(map, v, k) end)

  def map byte do
    @char_sets[byte] || byte
  end

  def unmap charset do
    @char_sets_by_code[charset] || charset
  end
end
