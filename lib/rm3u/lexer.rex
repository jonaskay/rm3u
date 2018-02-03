class Rm3u::Parser
macro 
  BLANK     ^\s+
  EXT       ^\#EXT[^\s:]+
  EXT_TEXT  \A:.*$
  EXTINF    ^\#EXTINF
  EXTM3U    ^\#EXTM3U\s*$
  PATH      ^[^\#].+$
  REM       ^\#.*$

rule
# [:state]  pattern     [actions]
            {BLANK}     # no action
            {EXTM3U}    { [:EXTM3U, text.strip] }
            {EXTINF}    { @state = :EXTINF; [:EXTINF, text] }
            {EXT}       { @state = :EXT; [:EXT, text] }
            {REM}       { [:REM, text.strip] }
            {PATH}      { [:PATH, text.strip] }

  :EXTINF   {EXT_TEXT}  { @state = nil; [:EXT_TEXT, text[1..-1].strip]}
  :EXTINF   .*$         { @state = nil; }

  :EXT      {EXT_TEXT}  { @state = nil; [:EXT_TEXT, text[1..-1].strip]}
  :EXT      .*$         { @state = nil; }

inner   
  def tokenize(input)    
    scan_setup(input)
    tokens = []
    while token = next_token
        tokens << token 
    end 
    tokens
  end 
end
