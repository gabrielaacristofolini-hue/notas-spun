#!/bin/sh
# Uso: ./registrar.sh "OPERAÇÃO" "TIPO" "o que aconteceu"
# Acrescenta uma linha com data e hora no fim de historico.txt (não publica; rode publicar.sh depois).
set -e
cd "$(dirname "$0")"
[ $# -eq 3 ] || { echo 'Uso: ./registrar.sh "OPERAÇÃO" "TIPO" "texto"'; exit 1; }
printf '%s | %s | %s | %s\n' "$(date '+%d/%m/%Y %H:%M')" "$1" "$2" "$3" >> historico.txt
