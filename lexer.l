%{
#include "parser.tab.h"
%}

%option noyywrap

digit [0-9]
letter [a-zA-Z]

%%
"if" {
    return KW_IF;
}
"else" {
    return KW_ELSE;
}
"while" {
    return KW_WHILE;
}
"for" {
    return KW_FOR;
}
"in" {
    return KW_IN;
}
"break" {
    return KW_BREAK;
}
"continue" {
    return KW_CONTINUE;
}
"read" {
    return KW_READ;
}
"write" {
    return KW_WRITE;
}

"=" {
    return OP_EQUAL;
}

"+" {
    return OP_PLUS;
}
"-" {
    return OP_MINUS;
}
"*" {
    return OP_STAR;
}
"/" {
    return OP_SLASH;
}
"%" {
    return OP_PERCENT;
}

"!=" {
    return OP_NOT_EQUAL;
}
"==" {
    return OP_EQUAL_EQUAL;
}
"<" {
    return OP_LESS;
}
"<=" {
    return OP_LEQUAL;
}
">" {
    return OP_GREATER;
}
">=" {
    return OP_GEQUAL;
}

":" {
    return SEP_COLON;
}
";" {
    return SEP_SEMI;
}
"(" {
    return SEP_LPAREN;
}
")" {
    return SEP_RPAREN;
}
"[" {
    return SEP_LBRACKET;
}
"]" {
    return SEP_RBRACKET;
}
"{" {
    return SEP_LBRACE;
}
"}" {
    return SEP_RBRACE;
}

{letter}(_|{letter}|{digit})* {
    return IDENT;
}

{digit}+ {
    return LIT_NUMBER;
}

\"[^\"]*\" {
    return LIT_STRING;
}

[ \t\n\r]+ /* Skip whitespace */

. {
    printf("Lexer error: unknown character '%s'\n", yytext);
}
%%