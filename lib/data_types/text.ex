defmodule MMS.Text do
  @moduledoc """
  8.4.2.1 Basic rules

  Text = Char *TEXT End-of-string

  This is a convenience codec that handles null terminated text strings.
  Text is any sequence of bytes starting with a "char" and terminated with a "\0".

  End-of-string = <Octet 0>

  From RFC 2616 Hypertext Transfer Protocol -- HTTP/1.1

  2.2 Basic Rules

       OCTET          = <any 8-bit sequence of data>
       CTL            = <any US-ASCII control character
                        (octets 0 - 31) and DEL (127)>
       CR             = <US-ASCII CR, carriage return (13)>
       LF             = <US-ASCII LF, linefeed (10)>
       SP             = <US-ASCII SP, space (32)>
       HT             = <US-ASCII HT, horizontal-tab (9)>

  HTTP/1.1 defines the sequence CR LF as the end-of-line marker for all
  protocol elements except the entity-body (see appendix 19.3 for
  tolerant applications). The end-of-line marker within an entity-body
  is defined by its associated media type, as described in section 3.7.

       CRLF           = CR LF

  HTTP/1.1 header field values can be folded onto multiple lines if the
  continuation line begins with a space or horizontal tab. All linear
  white space, including folding, has the same semantics as SP. A
  recipient MAY replace any linear white space with a single SP before
  interpreting the field value or forwarding the message downstream.

       LWS            = [CRLF] 1*( SP | HT )

  The TEXT rule is only used for descriptive field contents and values
  that are not intended to be interpreted by the message parser. Words
  of *TEXT MAY contain characters from character sets other than ISO-
  8859-1 [22] only when encoded according to the rules of RFC 2047
  [14].

       TEXT           = <any OCTET except CTLs, but including LWS>

  A CRLF is allowed in the definition of TEXT only as part of a header
  field continuation. It is expected that the folding LWS will be
  replaced with a single SP before interpretation of the TEXT value.
  """

  @end_of_string <<0>>

  use MMS.Codec

  def decode(bytes = <<byte, _::binary>>) when is_char(byte) do
    bytes
    |> String.split(@end_of_string, parts: 2)
    |> do_decode
  end

  def decode bytes do
    error bytes, :must_start_with_a_char
  end

  defp do_decode [string | [rest]] do
    ok string, rest
  end

  defp do_decode [string | []] do
    error string, :missing_end_of_string
  end

  def encode(string = <<char, _::binary>>) when is_char(char) do
    string
    |> do_encode(String.contains?(string, @end_of_string))
  end

  def encode string = "" do
    string
    |> do_encode(false)
  end

  def encode(string) when is_binary(string) do
    error string, :must_start_with_a_char
  end

  def encode value do
    error value, :invalid_type
  end

  defp do_encode string, _end_of_string = true do
    error string, :contains_end_of_string
  end

  defp do_encode string, _end_of_string = false do
    ok string <> @end_of_string
  end
end
