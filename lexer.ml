# 1 "lexer.mll"
 
exception Error
open Parser

let keywords = Hashtbl.create 17
let check_keyword s =
  try Hashtbl.find keywords s with Not_found -> IDENT s
and add_keyword s k = Hashtbl.add keywords s k
;;

add_keyword "var" VAR ;
add_keyword "alloc" ALLOC ;
add_keyword "false" (BOOL false) ;
add_keyword "true"  (BOOL true) ;
add_keyword "read" READ ;
add_keyword "write" WRITE ;
add_keyword "writeln" WRITELN ;
add_keyword "array" ARRAY ;
add_keyword "of" OF ;
add_keyword "do" DO ;
add_keyword "begin" BEGIN ;
add_keyword "end" END ;
add_keyword "if" IF ;
add_keyword "then" THEN ;
add_keyword "else" ELSE ;
add_keyword "while" WHILE ;
add_keyword "type" TYPE ;
add_keyword "function" FUNCTION ;
add_keyword "procedure" PROCEDURE ;
add_keyword "integer" INTEGER ;
add_keyword "boolean" BOOLEAN ;
add_keyword "program" PROGRAM ; ()
;;


# 38 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\231\255\232\255\233\255\234\255\235\255\236\255\237\255\
    \238\255\239\255\241\255\002\000\033\000\003\000\033\000\250\255\
    \076\000\095\000\004\000\010\000\255\255\254\255\253\255\152\000\
    \153\000\000\000\179\000\249\255\248\255\246\255\247\255\245\255\
    ";
  Lexing.lex_backtrk = 
   "\025\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\012\000\011\000\015\000\013\000\255\255\
    \004\000\003\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \002\000\003\000\003\000\255\255\255\255\255\255\255\255\255\255\
    ";
  Lexing.lex_default = 
   "\255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\255\255\000\000\
    \255\255\255\255\018\000\019\000\000\000\000\000\000\000\018\000\
    \018\000\255\255\255\255\000\000\000\000\000\000\000\000\000\000\
    ";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\020\000\020\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \020\000\000\000\018\000\000\000\000\000\000\000\022\000\025\000\
    \004\000\003\000\006\000\007\000\010\000\008\000\015\000\005\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\013\000\014\000\012\000\009\000\011\000\031\000\
    \028\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\002\000\027\000\001\000\029\000\030\000\
    \023\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\019\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\025\000\021\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\024\000\022\000\000\000\000\000\000\000\000\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\025\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\023\000\023\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\000\000\000\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \255\255\255\255\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\000\000\255\255\255\255\255\255\018\000\025\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\011\000\
    \013\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\014\000\000\000\012\000\012\000\
    \018\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\017\000\019\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\023\000\024\000\255\255\255\255\255\255\255\255\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
    \017\000\017\000\026\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\023\000\024\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\018\000\255\255\255\255\255\255\
    \255\255\255\255\019\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \023\000\024\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 38 "lexer.mll"
                   ( token lexbuf )
# 191 "lexer.ml"

  | 1 ->
# 39 "lexer.mll"
                        ( token lexbuf )
# 196 "lexer.ml"

  | 2 ->
# 41 "lexer.mll"
                   ( STRING (Lexing.lexeme lexbuf) )
# 201 "lexer.ml"

  | 3 ->
# 43 "lexer.mll"
                   (  check_keyword (Lexing.lexeme lexbuf) )
# 206 "lexer.ml"

  | 4 ->
# 44 "lexer.mll"
                   ( INT(int_of_string (Lexing.lexeme lexbuf)) )
# 211 "lexer.ml"

  | 5 ->
# 45 "lexer.mll"
                   ( DOT )
# 216 "lexer.ml"

  | 6 ->
# 46 "lexer.mll"
                   ( SEMISEMI )
# 221 "lexer.ml"

  | 7 ->
# 47 "lexer.mll"
                   ( COLONEQUAL )
# 226 "lexer.ml"

  | 8 ->
# 48 "lexer.mll"
                   ( LESSGREATER )
# 231 "lexer.ml"

  | 9 ->
# 49 "lexer.mll"
                   ( LESSEQUAL )
# 236 "lexer.ml"

  | 10 ->
# 50 "lexer.mll"
                   ( GREATEREQUAL )
# 241 "lexer.ml"

  | 11 ->
# 51 "lexer.mll"
                   ( LESS )
# 246 "lexer.ml"

  | 12 ->
# 52 "lexer.mll"
                   ( GREATER )
# 251 "lexer.ml"

  | 13 ->
# 53 "lexer.mll"
                   ( SEMI )
# 256 "lexer.ml"

  | 14 ->
# 54 "lexer.mll"
                   ( COMMA )
# 261 "lexer.ml"

  | 15 ->
# 55 "lexer.mll"
                   ( COLON )
# 266 "lexer.ml"

  | 16 ->
# 56 "lexer.mll"
                   ( EQUAL )
# 271 "lexer.ml"

  | 17 ->
# 57 "lexer.mll"
                   ( MINUS )
# 276 "lexer.ml"

  | 18 ->
# 58 "lexer.mll"
                   ( PLUS )
# 281 "lexer.ml"

  | 19 ->
# 59 "lexer.mll"
                   ( TIMES )
# 286 "lexer.ml"

  | 20 ->
# 60 "lexer.mll"
                   ( DIV )
# 291 "lexer.ml"

  | 21 ->
# 61 "lexer.mll"
                   ( LPAREN )
# 296 "lexer.ml"

  | 22 ->
# 62 "lexer.mll"
                   ( RPAREN )
# 301 "lexer.ml"

  | 23 ->
# 63 "lexer.mll"
                   ( LBRACKET )
# 306 "lexer.ml"

  | 24 ->
# 64 "lexer.mll"
                   ( RBRACKET )
# 311 "lexer.ml"

  | 25 ->
# 65 "lexer.mll"
                   ( raise Error )
# 316 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;
