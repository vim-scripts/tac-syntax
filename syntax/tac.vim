" Vim syntax file
" Language:     Tac
" Filenames:    *.tac
" Maintainers:  Vincent Aravantinos <vincent.aravantinos@gmail.com>
" Last Change:  2010 Jun 25 - Initial version.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax") && b:current_syntax == "tac"
  finish
endif

"syn case match

syn match tacError "#\S*" 
syn match    tacComment   "%.*"

syn match tacStatement "\."
syn keyword tacKwd contained pi sigma nu mu nabla
syn region tacLanguagePar contains=@tacLanguage contained matchgroup=tacLanguage start="(" end=")"
syn match tacKwd contained contains=tacLanguagePar +,\|;\|\\\|=>\|=\|"\|_+
syn cluster tacLanguage contains=tacKwd,tacLanguagePar

syn match tacTactical contained ","

syn region tacTacticalArg contained contains=@tacLanguage start=+"+ end=+"+ keepend
syn region tacTacticalPar contains=@tacTacticals contained matchgroup=tacTactical start="(" end=")"
syn match tacTactical "\(abstract\|admit\|and\(_l\|_r\)\?\|andthen\|apply\|assert_fail\|async\|axiom\|cases\|coinduction\|complete\|contract_l\|cut\|cut_lemma\|eq\(_l\|_r\)\?\|examine\|examine_pattern\|fail\|false\|find\|first\|focus\|focus_r\|force\|freeze\|id\|imp\(_l\|_r\)\?\|induction\|intros\|iterate\|left\|mu_l\|mu_r\|nabla\(_l\|_r\)\?\|nu_l\|nu_r\|or_l\|orelse\|pi\(_l\|_r\)\?\|prove\|repeat\|right\|rotate\(_l\)\?\|set_bound\|sigma\(_l\|_r\)\?\|simplify\|sync\|then\|trivial\|true\|try\|unfocus\|weak_l\)"
syn region tacProof contains=@tacTacticals,tacTacticalArg matchgroup=tacTactical start="\(abstract\|admit\|and\(_l\|_r\)\?\|andthen\|apply\|assert_fail\|async\|axiom\|cases\|coinduction\|complete\|contract_l\|cut\|cut_lemma\|eq\(_l\|_r\)\?\|examine\|examine_pattern\|fail\|false\|find\|first\|focus\|focus_r\|force\|freeze\|id\|imp\(_l\|_r\)\?\|induction\|intros\|iterate\|left\|mu_l\|mu_r\|nabla\(_l\|_r\)\?\|nu_l\|nu_r\|or_l\|orelse\|pi\(_l\|_r\)\?\|prove\|repeat\|right\|rotate\(_l\)\?\|set_bound\|sigma\(_l\|_r\)\?\|simplify\|sync\|then\|trivial\|true\|try\|unfocus\|weak_l\)\s*(" end=")"

syn cluster tacTacticals contains=tacProof,tacTactical,tacTacticalPar

syn region tacTacticalName contains=@tacTacticals contained matchgroup=tacId start="\S\+" end="\."
syn region tacTacticalDef contains=tacTacticalName matchgroup=tacStatement start="#tactical" end="\." keepend

syn region tacDefinitionRHS contained contains=@tacLanguage matchgroup=tacLanguage start=+:=+ end=+"+
syn region tacDefinedSymbol contained contains=tacDefinitionRHS matchgroup=tacId start="\(\(co\)\?inductive\s\+\)\?\S\+" end=+"+ keepend
syn region tacDefinition contained contains=tacDefinedSymbol matchgroup=tacLanguage start=+"+ end=+"+ keepend
syn region tacDefine contains=tacDefinition matchgroup=tacStatement start=+#define+ end=+\.+ keepend

syn region tacTheoremStmt contained contains=@tacLanguage matchgroup=tacLanguage start=+"+ end=+"+ keepend
syn region tacTheoremName contained contains=tacTheoremStmt matchgroup=tacId start="\S\+" end="\." 
syn region tacTheorem contains=tacTheoremName matchgroup=tacStatement start=+#\(theorem\|lemma\)+ end=+\.+ keepend

syn match tacLogicName contained +"\(none\|propositional\|muLJ\|muLJ-nonstrict\|firstorder-nonstrict\|firstorder\)"+
syn region tacLogic contains=tacLogicName matchgroup=tacStatement start=+#logic+ end=+\.+

" extension .def used in the examples
syn match tacFile contained +"\f*\.\(tac\|def\)"+
syn region tacOpen contains=tacFile matchgroup=tacStatement start=+#open+ end=+\.+

syn match tacDir contained +"\f*"+
syn region tacProofOutput contains=tacDir matchgroup=tacStatement start=+#proof_output+ end=+\.+

syn match tacLPFile contained +"\f*\.mod"+
syn region tacInclude contains=tacLPFile matchgroup=tacStatement start=+#include+ end=+"\.+

syn keyword tacOnOff contained on off
syn region tacDebug contains=tacOnOff matchgroup=tacStatement start="#debug" end="\."
syn region tacTime contains=tacOnOff matchgroup=tacStatement start="#time" end="\."

syn match tacProperty contained +"\S*"+
syn region tacGet contains=tacProperty matchgroup=tacStatement start=+#get+ end=+\.+

syn match tacValue contained +"\S*"+
syn region tacSet contains=tacProperty,tacValue matchgroup=tacStatement start=+#set+ end=+\.+

syn match tacFunction contains=tacStatement "[[:upper:]][[:alpha:][:digit:]']*([^)]\{-})"
syn match tacOperators "[[:lower:]][[:lower:][:digit:]']*=[[:digit:]]*\.\.[[:lower:]][[:lower:][:digit:]']*\%(\%(+\|-\)[[:digit:]]*\)\?"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_tac_syntax_inits")
  if version < 508
    let did_tac_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink tacError		  Error
  HiLink tacComment   Comment
  HiLink tacStatement PreProc
  HiLink tacProperty  String
  HiLink tacValue     String
  HiLink tacLogicName String
  HiLink tacFile      String
  HiLink tacLPFile    String
  HiLink tacDir       String
  HiLink tacOnOff     String
  HiLink tacProperty  String
  HiLink tacValue     String
  HiLink tacLanguage  Keyword
  HiLink tacKwd       Keyword
  HiLink tacId        String
  HiLink tacTactical Type

  delcommand HiLink
endif

let b:current_syntax = "tac"

