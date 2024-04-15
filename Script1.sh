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






interactive=1



# Analizza le opzioni dello script
while getopts ":r" opt; do # sta analizzando le opzioni passate allo script
  case ${opt} in
    r )
      recursive=1
      ;;
  esac
done
shift $((OPTIND -1)) # rimuovere le opzioni che sono state analizzate da getopts





# Richiesta dei parametri all'utente
echo -n "Inserisci il pathname della directory sorgente: " 
read src
echo -n "Inserisci il pathname della directory destinazione: " 
read dst


# Controllo se i path inseriti esistono
if [ ! -d "$src" ]; then # se non è una directory stampa l'errore
    echo ""
    echo "Errore: Il pathname della directory sorgente inserito non esiste." >&2 #stderr, canale standard output
    exit 1 # indica che si è verificato un errore
fi

if [ ! -d "$dst" ]; then
    echo ""
    echo "Errore: Il pathname della directory destinazione inserito non esiste." >&2
    exit 1
fi



# Se l'opzione -r è stata fornita, esegue lo script ricorsivamente sulle sottocartelle
if [ $recursive -eq 1 ]; then # -eq equal per la comparazione
  for subdir in $(find "$src" -type d); do
    # Calcola il corrispondente sottodirectory nella directory destinazione
    dst_subdir="${dst}${subdir#$src}" # sta prendendo il valore di dst, concatenandolo con il valore di subdir dopo aver rimosso il prefisso src, e assegnando il risultato a dst_subdir
    # Esegue lo script sulla sottodirectory
    bash "$0" "$subdir" "$dst_subdir"
  done
fi



# Controllo se i parametri sono link simbolici
if [ -L "$src" ] || [ -L "$dst" ]; then # -L usata per seguire i link simbolici
    echo ""
    echo "Errore: I pathname non devono essere link simbolici." >&2
    exit 1
fi

# Controllo se le directory sono una contenuta nell'altra
if [[ $src == $dst* ]] || [[ $dst == $src* ]]; then
    echo ""
    echo "Errore: Le due directory non devono essere una contenuta nell'altra." >&2
    exit 
fi

echo ""
echo -e "\e[32m
Le directory fornite non sono link simbolici e non sono una contenuta nell'altra.
\e[0m"


# Esamina tutti i file regolari nella directory destinazione
for file in "$dst"/*; do
    # Se il file non esiste nella directory sorgente, lo elimina
    if [ -f "$file" ] && [ ! -e "$src/$(basename "$file")" ]; then # verifica se è un file regolare & verifica se non esiste un file con lo stesso nome in src
        rm "$file"
        echo ""
            echo -e "\e[32m
File eliminato correttamente
    \e[0m"  
    fi
done


# Esamina tutti i file regolari nella directory sorgente
for file in "$src"/*; do
    dst_file="$dst/$(basename "$file")"
    
    # Se il file non esiste nella directory destinazione, o se la data di modifica è diversa, lo copia
        if [ ! -e "$dst_file" ] || [ "$(stat -c %Y "$file")" -ne "$(stat -c %Y "$dst_file")" ]; then # condizione che viene eseguita se $dst_file non esiste o se l’ora dell’ultima modifica di $file è diversa da quella di $dst_file
          # Se l'opzione -i è stata fornita, chiede conferma all'utente
         if [ $interactive -eq 1 ]; then
          echo ""
              read -p "Vuoi copiare $file a $dst_file? (y/n) " confirm  # -p visualizza un messaggio o un prompt per l’utente prima di leggere l’input
              confirm=$(echo $confirm | tr '[:upper:]' '[:lower:]') # echo $confirm stampa il valore di confirm.
              if [ "$confirm" != "y" ]; then         # tr '[:upper:]' '[:lower:]' converte le lettere maiuscole in minuscole.
    echo ""            # confirm=$(...) assegna il risultato alla variabile confirm 
    echo -e "\e[31m
File non copiato
    \e[0m"     
                     continue
              fi
         fi
            cp "$file" "$dst_file"
            echo ""
            echo -e "\e[32m 
Copiato nella directory di destinazione.
	\e[0m"
        fi
done

echo ""
echo ""
echo -e "\e[33m

	Aggiornamento completato con successo
\e[0m"
