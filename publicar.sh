#!/bin/sh
# Uso: ./publicar.sh "mensagem do commit"
# Atualiza a data em notas.json, valida o JSON, faz commit e sobe para a main.
set -e
cd "$(dirname "$0")"
git pull -q origin main
DATA="$(date '+%d/%m/%Y às %H:%M')"
sed -i "s|\"atualizado\": \"[^\"]*\"|\"atualizado\": \"$DATA\"|" notas.json
if command -v node >/dev/null 2>&1; then node -e 'JSON.parse(require("fs").readFileSync("notas.json","utf8"))'; fi
if command -v perl >/dev/null 2>&1; then perl -MJSON::PP -e 'local $/; open F,"<:utf8","notas.json" or die; JSON::PP->new->decode(<F>)' || { echo "notas.json invalido"; exit 1; }; fi
git add notas.json index.html favicon.svg publicar.sh registrar.sh historico.txt dailies.txt
git commit -q -m "${1:-Atualiza notas}

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push -q origin main
echo "Publicado: $DATA ($(git rev-parse --short HEAD))"
