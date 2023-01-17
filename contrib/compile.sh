#!/bin/sh
set -e

mkdir -p build
bison -Wcounterexamples -d --file-prefix build/parser parser.y
flex -o build/lexer.yy.c lexer.l
gcc -Wall build/parser.tab.c -o build/parser
chmod a+x build/parser

