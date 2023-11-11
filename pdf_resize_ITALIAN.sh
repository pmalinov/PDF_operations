#!/bin/bash
# rev. 1.0 # pmalinov

# Controllo i parametri
if [ $# -ne 1 ]; then
  echo "Errore: Specificare il percorso del file PDF da ridimensionare."
  exit 1
fi

# Leggi il percorso del file PDF
input_file=$1

# Ottieni il percorso completo del file di output
output_file="${input_file%%.*}_small.pdf"

# Chiedi all'utente la modalità di ridimensionamento
echo "Quale modalità di ridimensionamento vuoi usare?"
echo "1. Schermo (72 dpi)"
echo "2. Ebook (150 dpi)"
echo "3. Stampante (300 dpi)"
echo "4. Prepress (300 dpi, preserva il colore)"
echo "5. Predefinito (quasi identico a Ebook)"

read -p "Seleziona una modalità (1-5): " option

# Componi il comando di ridimensionamento
dpi_setting=""
case $option in
  1) dpi_setting="-dPDFSETTINGS=/screen" ;;
  2) dpi_setting="-dPDFSETTINGS=/ebook" ;;
  3) dpi_setting="-dPDFSETTINGS=/printer" ;;
  4) dpi_setting="-dPDFSETTINGS=/prepress" ;;
  5) dpi_setting="-dPDFSETTINGS=/default" ;;
esac

# Esegui il comando
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 $dpi_setting -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file

# Verifica l'esito dell'operazione
if [ $? -ne 0 ]; then
  echo "Errore durante il ridimensionamento del file PDF."
  exit 1
fi

# Ottieni le dimensioni dei file di input e output in megabyte
input_file_size=$(du -h "$input_file" | awk '{print $1}')
output_file_size=$(du -h "$output_file" | awk '{print $1}')

# Stampa i percorsi completi dei file di input e output, nonché le loro dimensioni in megabyte
echo "File di input: $input_file ($input_file_size MB)"
echo "File di output: $output_file ($output_file_size MB)"
exit

# ##################### istruzioni in italiano #########################

# Rendi eseguibile lo script eseguendo il seguente comando:
# Bash
# chmod +x resize_pdf_IT.sh

# Esegui lo script passando il percorso del file PDF che desideri ridimensionare come argomento. 
# Ad esempio, per ridimensionare il file PDF /percorso/verso/file/input.pdf, eseguire il seguente comando:

# ./resize_pdf_IT.sh /percorso/verso/file/input.pdf
# Utilizza il codice con cautela. Scopri di più
# Lo script ti chiederà di selezionare una modalità di ridimensionamento. Puoi scegliere tra le seguenti opzioni:

# Schermo (72 dpi)

# Ebook (150 dpi)

# Stampante (300 dpi)

# Prepress (300 dpi, conserva il colore)

# Predefinito (quasi identico a Ebook)

# Lo script ridimensionerà quindi il file PDF e creerà un nuovo file PDF denominato /percorso/verso/file/input_small.pdf.

# Lo script stamperà inoltre i percorsi completi dei file di input e output, nonché le loro dimensioni, sulla console.

