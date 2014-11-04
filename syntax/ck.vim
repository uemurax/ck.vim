" Vim syntax file
" Language:	ChucK
" Maintained:	Eduard Aylon <eduard.aylon@gmail.com>
" Last Change:	28/02/2006
" Filenames:	*.ck
" Version:	0.1
" Adapted by Eduard Aylon <eduard.aylon@gmail.com> from the c.vim syntax file from Bram Moolenar <Bram@vim.org>

" NOTE: in order to obtain syntax highlighting in Chuck programs just follow the
"       steps below or in case you don't have root privileges follow Graham Percival's tip : 
"	1. copy this file into /usr/share/vim/vim62/syntax.
"	2. add the following line in /usr/share/vim/filetype.vim, 
"       
"		au BufNewFile,BufRead *.ck          setf ck
"		


"Tip from Graham Percival:
" If you cannot write to /usr/share/  (lacking root privileges),
    "   enter these commands:
    "     $ echo "syntax on" >> ~/.vimrc
    "     $ mkdir ~/.vim
    "     $ mkdir ~/.vim/syntax
    "     $ cp ck.vim ~/.vim/syntax/
    "     $ echo "if exists(\"did_load_filetypes\")
    "           finish
    "         endif
    "         augroup filetypedetect
    "          au! BufNewFile,BufRead *.ck setf ck
    "          augroup END" >> ~/.vim/filetype.vim




" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"catch errors caused by wrong parenthesis and brackets
" also accept <% for {, %> for }, <: for [ and :> for ] (C99)
" TODO: add the debug print `<<< ... >>>'
syn cluster     cParenGroup contains=cParenError,cIncluded,cSpecial,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cUserCont,cUserLabel,cBitField,cCommentSkip,cOctalZero,cCppOut,cCppOut2,cCppSkip,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom
if exists("c_no_bracket_error")
  syn region    cParen          transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cCppString
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region    cCppParen       transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cParen,cString
  syn match     cParenError     display ")"
  syn match     cErrInParen     display contained "[{}]\|<%\|%>"
else
  syn region    cParen          transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cErrInBracket,cCppBracket,cCppString
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region    cCppParen       transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cErrInBracket,cParen,cBracket,cString
  syn match     cParenError     display "[\])]"
  syn match     cErrInParen     display contained "[\]{}]\|<%\|%>"
  syn region    cBracket        transparent start='\[\|<:' end=']\|:>' contains=ALLBUT,@cParenGroup,cErrInParen,cCppParen,cCppBracket,cCppString
  " cCppBracket: same as cParen but ends at end-of-line; used in cDefine
  syn region    cCppBracket     transparent start='\[\|<:' skip='\\$' excludenl end=']\|:>' end='$' contained contains=ALLBUT,@cParenGroup,cErrInParen,cParen,cBracket,cString
  syn match     cErrInBracket   display contained "[);{}]\|<%\|%>"
endif



if exists("c_no_cformat")
  syn region    cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial
  " cCppString: same as cString, but ends at end of line
  syn region    cCppString      start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial
else
  syn match     cFormat         display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([diuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
  syn match     cFormat         display "%%" contained
  syn region    cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,cFormat
  " cCppString: same as cString, but ends at end of line
  syn region    cCppString      start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,cFormat
endif


if exists("c_comment_strings")
  " A comment can contain cString, cCharacter and cNumber.
  " But a "*/" inside a cString in a cComment DOES end the comment!  So we
  " need to use a special type of cString: cCommentString, which also ends on
  " "*/", and sees a "*" at the start of the line as comment again.
  " Unfortunately this doesn't very well work for // type of comments :-(
  syntax match  cCommentSkip    contained "^\s*\*\($\|\s\+\)"
  syntax region cCommentString  contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
  syntax region cComment2String contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
  syntax region  cCommentL      start="//" skip="\\$" end="$" keepend  contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError
  syntax region cComment        matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError
else
  syn region    cCommentL       start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cSpaceError
  syn region    cComment        matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cSpaceError
endif


syn match ckNone                "\w\+\.\w\+"
syn match   ckNumber      "\<0x\x\+[Ll]\=\>"
syn match   ckNumber      "\<\d\+[LljJ]\=\>"
syn match   ckNumber      "\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   ckNumber      "\<\d\+\.\([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   ckNumber      "\<\d\+\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"


" CHUCK extentions
syn keyword ckKeyword     for while until repeat continue break if else do return function fun new class interface extends implements public protected private static pure const spork typeof
syn match cOperator       "++\|--\|::"
syn match cOperator       "\s\(+\|-\|\*\|/\|%\|==\|!=\|<\|>\|<=\|>=\|&&\|||\|&\||\|\^\|>>\|<<\|!\|\~\|@\|@@\)\s"
syn match ckOperator      "\s\(\S*=>\)\s"
syn match ckOperator      "\s\(=\^\|=<\)\s"
syn keyword ckPrimitive   int float time dur void complex polar
syn keyword ckDuration    smp ms second minute hour day week
syn keyword ckTime        now
syn keyword ckShred       me Machine
syn keyword ckBuiltin     Object Shred Event UGen
syn keyword ckSpecialUgen dac adc blackhole
syn keyword ckStdUgen     SinOsc PulseOsc SqrOsc TriOsc SawOsc Phasor Noise Impulse Step Gain SndBuf HalfRect FullRect ZeroX Min2 Pan2 GenX CurveTable WarpTable LiSa
syn keyword ckFilter      OneZero TwoZero OnePole TwoPole PoleZero BiQuad Filter LPF HPF BPF BRF ResonZ Dyno
syn keyword ckStkUgen     Envelope ADSR Delay DelayA DelayL Echo JCRev NRev PRCRev Chorus Modulate PitShift SubNoise Blit BlitSaw BlitSquare WvIn WaveLoop WvOut
syn keyword StkInst       StkInstrument BandedWG BlowBotl BlowHole Bowed Brass Clarinet Flute Mandolin ModalBar Moog Saxofony Shakers Sitar StifKarp VoicForm FM BeeThree FMVoices HevyMetl PercFlut Rhodey TubeBell Wurley
syn keyword ckBasicUana   UAna UAnaBlob Windowing
syn keyword ckTransform   FFT IFFT DCT IDCT
syn keyword ckFeatureExt  Centroid Flux RMS RollOff
syn keyword ckMidi        MidiIn MidiOut MidiMsg
syn keyword ckOsc         OscRecv OscSend OscEvent

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cCommentL		cComment
  HiLink cCommentStart		cComment
  HiLink cComment 		Comment
  HiLink cCppString             cString
  HiLink cString		String
  HiLink cType		        Type
  HiLink cParenError		cError
  HiLink cErrInBracket		cError
  HiLink cErrInParen		cError
  HiLink cParen			cError
  HiLink cCppParen		cError
  HiLink cBracket	  	cError
  HiLink cCppBracket	  	cError
  HiLink cError			Error
  HiLink ckNumber		Number
  HiLink ckKeyword              Statement
  HiLink ckOperator             Operator
  HiLink cOperator              Operator
  HiLink ckPrimitive            ckType
  HiLink ckDuration             ckConst
  HiLink ckTime                 ckConst
  HiLink ckShred                ckConst
  HiLink ckBuiltin              ckType
  HiLink ckSpecialUgen          ckConst
  HiLink ckStdUgen              ckUgen
  HiLink ckFilter               ckUgen
  HiLink ckStkUgen              ckUgen
  HiLink ckStkInst              ckUgen
  HiLink ckBasicUana            ckUana
  HiLink ckTransform            ckUana
  HiLink ckFeatureExt           ckUana
  HiLink ckMidi                 ckType
  HiLink ckOsc                  ckType
  HiLink ckUgen                 ckType
  HiLink ckUana                 ckType
  HiLink ckType                 Type
  HiLink ckConst                Constant
  
  delcommand HiLink
endif

let b:current_syntax = "ck"

" vim: ts=8
