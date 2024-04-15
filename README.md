# ShellForge

Script 1: 
Si realizzi uno script bash che implementi un comando "aggiorna" che accetta due parametri. 
I due parametri devono essere pathname (assoluti o relativi) di due directory, sorgente e 
destinazione; le due directory non devono essere una contenuta nell'altra. Lo script controlla 
che i due pathname non siano link simbolici. Nel caso lo siano, stampa un messaggio di errore 
sullo STDERR e termina con un exit status appropriato. 
Nel caso contrario (in ordine di difficoltà e di punteggio): 
1-lo script esamina tutti i file regolari contenuti nella prima directory e verifica se esistono nella 
seconda; se un file non esiste lo copia. (Notare che le copie avvengono solo in una direzione: un 
contenuto della cartella sorgente viene salvato nella destinazione ma non il contrario) 
2-In aggiunta al precedente, se uno dei file presenti nella cartella destinazione non esiste nella 
cartella sorgente, eliminare il file anche dalla cartella destinazione. 
3-In aggiunta al precedente, se la data di modifica di un file presente nella cartella sorgente è 
diversa da quella dello stesso file nella cartella destinazione, copiare comunque il file 
(suggerimento: studiare comando STAT). 
4-Aggiungere il flag -i alle opzioni dello script. Nel caso sia fornito, chiedere conferma prima di 
copiare un file 
5-Aggiungere il flag -r alle opzioni dello script. Nel caso sia fornito, richiamare lo script in 
maniera ricorsiva sulle sottocartelle. In alternativa, far sì che di default lo script venga chiamato 
ricorsivamente nelle sottocartelle.


Script 2: 
Si scriva uno script che permette la gestione di una rubrica in formato csv, con separatore “;”. 
La rubrica ha la seguente struttura, per ogni riga: 
Nome;Cognome;Numero di Telefono;Indirizzo 
Lo script deve fornire le seguenti funzioni, consultabili da un menu: 
1. Stampa della rubrica riga per riga; esempio per la riga “Mario;Rossi;123;Perugia”: 
“Nome e cognome: Mario Rossi, numero: 123, indirizzo: Perugia” 
2. Stampa di tutte le righe che contengono un cognome fornito dall’utente in input 
3. Modifica di tutte le occorrenze di un nome di città. 
4. Eliminazione di una riga fornita da un utente in input come numero, es. riga 3 
