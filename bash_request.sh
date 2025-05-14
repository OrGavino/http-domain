#!/bin/bash

START_TIME=$(date +%s)
SCAN_LIST=()
FAILS=()

mapfile -t SCAN_LIST < domains_list.txt

echo "Scan..."

for SITE in "${SCAN_LIST[@]}"
do
	STATUS=$(curl --silent --show-error --fail --max-time 2 -o /dev/null -w "%{http_code}" $SITE) 
	echo "${SITE} - ${STATUS} "
	if [[ "$STATUS" -ge 400 || "$STATUS" -eq 000 ]];then
	FAILS+=("$SITE")
	fi
done

echo "Scan finalizado!"

END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

echo "O script levou ${TOTAL_TIME} para rodar."

if [[ ${#FAILS[@]} -gt 0 ]]; then
    echo -e "\nOs dominios que falharam foram:"
    for fail in "${FAILS[@]}"; do
        echo "$fail"
    done
else
    echo -e "\nNenhum dominio falhou."
fi
