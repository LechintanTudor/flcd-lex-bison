%{
#define YY_NO_INPUT
#define YY_NO_UNPUT

#include "lexer.yy.c"

#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char* s);
%}

%token KW_IF
%token KW_ELSE
%token KW_WHILE
%token KW_FOR
%token KW_IN
%token KW_BREAK
%token KW_CONTINUE
%token KW_READ
%token KW_WRITE

%token OP_EQUAL

%token OP_PLUS
%token OP_MINUS
%token OP_STAR
%token OP_SLASH
%token OP_PERCENT

%token OP_NOT_EQUAL
%token OP_EQUAL_EQUAL
%token OP_LESS
%token OP_LEQUAL
%token OP_GREATER
%token OP_GEQUAL

%token SEP_COLON
%token SEP_SEMI
%token SEP_LPAREN
%token SEP_RPAREN
%token SEP_LBRACKET
%token SEP_RBRACKET
%token SEP_LBRACE
%token SEP_RBRACE

%token IDENT

%token LIT_NUMBER
%token LIT_STRING

%left OP_PLUS OP_MINUS
%left OP_STAR OP_SLASH OP_PERCENT
%left OP_NOT_EQUAL OP_EQUAL_EQUAL OP_LESS OP_LEQUAL OP_GREATER OP_GEQUAL

%start program

%%
program: stmt_list
stmt_list: nonempty_stmt_list | /* Empty */
nonempty_stmt_list: stmt | stmt nonempty_stmt_list

stmt
    : stmt_decl
    | stmt_assign
    | stmt_if
    | stmt_if_else
    | stmt_while
    | stmt_for
    | stmt_read
    | stmt_write
    
stmt_if: KW_IF SEP_LBRACE stmt_list SEP_RBRACE
stmt_if_else: stmt_if KW_ELSE SEP_LBRACE stmt_list SEP_RBRACE
stmt_decl: IDENT SEP_COLON OP_EQUAL expr SEP_SEMI
stmt_assign: IDENT OP_EQUAL expr SEP_SEMI
stmt_while: KW_WHILE expr SEP_LBRACE stmt_list SEP_RBRACE
stmt_for: KW_FOR IDENT KW_IN expr SEP_LBRACE stmt_list SEP_RBRACE
stmt_read: KW_READ IDENT SEP_SEMI
stmt_write: KW_WRITE expr SEP_SEMI

expr
    : IDENT
    | LIT_NUMBER
    | LIT_STRING
    | arithmetic_expr
    | relational_expr
    | SEP_LPAREN expr SEP_RPAREN

arithmetic_expr
    : expr OP_PLUS expr
    | expr OP_MINUS expr
    | expr OP_STAR expr
    | expr OP_SLASH expr
    | expr OP_PERCENT expr
    
relational_expr
    : expr OP_NOT_EQUAL expr
    | expr OP_EQUAL_EQUAL expr
    | expr OP_LESS expr
    | expr OP_LEQUAL expr
    | expr OP_GREATER expr
    | expr OP_GEQUAL expr
%%

extern FILE* yyin;

int yyerror(char* s) {
    printf("Parser error: %s\n", s);
    return 1;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Invalid number of arguments\n");
        return 1;
    }

    yyin = fopen(argv[1], "r");

    if (yyin == NULL) {
        printf("Failed to open file\n");
        return 2;
    }

    if (yyparse()) {
        printf("Failed to parse program\n");
        return 1;
    }

    printf("Program parsed successfully\n");
    return 0;
}
