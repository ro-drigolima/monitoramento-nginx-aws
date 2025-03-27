#!/bin/bash
  # Script de monitoramento do site local (localhost) com alerta via Telegram

  # URL a ser monitorada
  URL="http://localhost"
  TOKEN="SEU_TOKEN_AQUI"
  CHAT_ID="SEU_CHAT_ID_AQUI"
  LOG="/home/ubuntu/monitoramento.log"

  STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)

  if [ "$STATUS" -ne 200 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Site fora do ar (status $STATUS)" >> $LOG
    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage \
      -d chat_id=$CHAT_ID \
      -d text="🚨 ALERTA: O servidor Nginx está fora do ar! Código: $STATUS"
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - OK (status $STATUS)" >> $LOG
  fi