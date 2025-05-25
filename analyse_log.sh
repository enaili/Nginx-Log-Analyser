#!/bin/bash

# Fichier de log à analyser
LOGFILE="access.log"

# Vérifie si le fichier de log existe
if [ ! -f "$LOGFILE" ]; then
  echo "Fichier '$LOGFILE' introuvable. Assure-toi qu'il est dans le même dossier que ce script."
  exit 1
fi

echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\nTop 5 most requested paths:"
awk -F\" '{print $2}' "$LOGFILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\nTop 5 response status codes:"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\nTop 5 user agents:"
awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $0}'

