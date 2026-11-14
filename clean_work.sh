#!/bin/zsh
# Limpa cache DNS
sudo dscacheutil -flushcache; sudo killall -HUPmDNSResponder
# Limpa historico do terminal
history -c
# Limpa arquivos temporarios de sistema
sudo rm -rf/private/var/folders/*
echo "Ambiente de Trabalho Aegis Limpo"
