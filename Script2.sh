#!/bin/bash



echo -e "\e[36m


  ██████  ██░ ██ ▓█████  ██▓     ██▓      █████▒▒█████   ██▀███    ▄████ ▓█████ 
▒██    ▒ ▓██░ ██▒▓█   ▀ ▓██▒    ▓██▒    ▓██   ▒▒██▒  ██▒▓██ ▒ ██▒ ██▒ ▀█▒▓█   ▀ 
░ ▓██▄   ▒██▀▀██░▒███   ▒██░    ▒██░    ▒████ ░▒██░  ██▒▓██ ░▄█ ▒▒██░▄▄▄░▒███   
  ▒   ██▒░▓█ ░██ ▒▓█  ▄ ▒██░    ▒██░    ░▓█▒  ░▒██   ██░▒██▀▀█▄  ░▓█  ██▓▒▓█  ▄ 
▒██████▒▒░▓█▒░██▓░▒████▒░██████▒░██████▒░▒█░   ░ ████▓▒░░██▓ ▒██▒░▒▓███▀▒░▒████▒
▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░░ ▒░ ░░ ▒░▓  ░░ ▒░▓  ░ ▒ ░   ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░ ░▒   ▒ ░░ ▒░ ░
░ ░▒  ░ ░ ▒ ░▒░ ░ ░ ░  ░░ ░ ▒  ░░ ░ ▒  ░ ░       ░ ▒ ▒░   ░▒ ░ ▒░  ░   ░  ░ ░  ░
░  ░  ░   ░  ░░ ░   ░     ░ ░     ░ ░    ░ ░   ░ ░ ░ ▒    ░░   ░ ░ ░   ░    ░   
      ░   ░  ░  ░   ░  ░    ░  ░    ░  ░           ░ ░     ░           ░    ░  ░
                                                                                                                                                            
\e[0m"
echo -e "\e[35m   
Powered by:
zDevilMoon








\e[0m"








            
# Imposta la stringa di prompt per il comando select
PS3='Scegli un opzione: '

# Definisce le opzioni per il comando select
options=("Stampa della rubrica" "Cerca per cognome" "Modifica città" "Elimina riga" "Esci")

# Usa il comando select per creare un menu usando l'array ${options[@]}
select opt in "${options[@]}" # @ è usato per fare riferimento a tutti gli elementi di un array
do
   echo ""
    case $opt in
        "Stampa della rubrica")
            # Usa awk per stampare il contenuto della rubrica (rubrica.csv)
            # awk serve a manipolare i dati e a generare report
            awk -F ';' '{print "Nome e cognome: " $1 " " $2 ", numero: " $3 ", indirizzo: " $4}' rubrica.csv
            echo ""
            ;;
        "Cerca per cognome")
            # Chiede all'utente di inserire un cognome
            echo -n "Inserisci il cognome: "
            read cognome
            echo ""
            # Cerca nella rubrica il cognome inserito e stampa il risultato
            # il comando grep viene usato per creare una stringa di testo in uno o più file -i rende la ricerca non case sensitive per trovare la stessa parola con maiuscolo o minuscolo
            result=$(grep -i "$cognome" rubrica.csv | awk -F ';' '{print "Nome e cognome: " $1 " " $2 ", numero: " $3 ", indirizzo: " $4}')
            # Se il risultato è vuoto, stampa un messaggio che dice che il cognome non esiste
            # -z result serve a restituire vero se la variabile result è vuota o indefinita ovvero se è 0
            if [[ -z "$result" ]]; then
      echo -e "\e[31m
Cognome inesistente
\e[0m"
     else
      echo "$result"
     fi
     echo ""
            ;;
           "Modifica città")
            # Chiede all'utente di inserire una città da modificare
            echo -n "Inserisci la città da modificare: "
            read old_city
            # Se la città esiste nella rubrica, chiede all'utente di inserire una nuova città e sostituisce la vecchia città con la nuova
            if grep -q "$old_city" rubrica.csv; then
                echo -n "Inserisci la nuova città: "
                read new_city
                sed -i "s/$old_city/$new_city/g" rubrica.csv   # questa riga è ustata per sostituire tutte le occorrenze di una stringa in un file
                echo ""                                        # sed è un editor per manipolare il testo -i serve a fare le modifiche nel file di origine mentre s/$old_city/$new_city/g è ciò che sed eseguirà sul file
                echo -e "\e[32m
Città cambiata correttamente
\e[0m"
            else
             echo ""
                echo -e "\e[31m
La città da modificare non è presente nella rubrica
\e[0m"
            fi
            echo ""
            ;;
        "Elimina riga")
            # Chiede all'utente di inserire un numero di riga da eliminare
            echo -n "Inserisci il numero della riga da eliminare: "
            read row
            # Se il numero di riga è minore o uguale al numero di righe nella rubrica, elimina la riga
            if [ "$row" -le "$(wc -l < rubrica.csv)" ]; then # Verifica se il numero di riga inserito è minore o uguale al numero totale di righe nel file csv
                sed -i "${row}d" rubrica.csv
                echo ""
                echo -e "\e[32m
Riga eliminata correttamente
\e[0m"
            else
                echo ""
                echo -e "\e[31m
Il numero della riga da eliminare non è presente nella rubrica
\e[0m"
            fi
            echo ""
            ;;
        "Esci")
            # Esce dallo script
            echo -e "\e[93mScript terminato con successo!\e[0m"
            break
            ;;
        *) echo -e "\e[31m
Opzione non valida
\e[0m" 
        echo ""
        ;;
    esac
done
