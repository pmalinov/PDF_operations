#!/bin/bash
# rev. 1.0 # pmalinov

# Проверка на параметрите
if [ $# -ne 1 ]; then
  echo "Грешка: Моля, посочете пътя към PDF файла, който искате да преоразмерите."
  exit 1
fi

# Четене на пътя към PDF файла
input_file=$1

# Получаване на пълния път към изходния файл
output_file="${input_file%%.*}_small.pdf"

# Вземете от потребителя режима на преоразмеряване
echo "Кой режим на преоразмеряване искате да използвате?"
echo "1. Екран (72 dpi)"
echo "2. Е-книга (150 dpi)"
echo "3. Принтер (300 dpi)"
echo "4. Предпечат (300 dpi, запазва цвета)"
echo "5. По подразбиране (почти идентично на Е-книга)"

read -p "Изберете режим (1-5): " option

# Композиране на командата за преоразмеряване
dpi_setting=""
case $option in
  1) dpi_setting="-dPDFSETTINGS=/screen" ;;
  2) dpi_setting="-dPDFSETTINGS=/ebook" ;;
  3) dpi_setting="-dPDFSETTINGS=/printer" ;;
  4) dpi_setting="-dPDFSETTINGS=/prepress" ;;
  5) dpi_setting="-dPDFSETTINGS=/default" ;;
esac

# Изпълнение на командата
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 $dpi_setting -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file

# Проверка на резултата от операцията
if [ $? -ne 0 ]; then
  echo "Грешка при преоразмеряването на PDF файла."
  exit 1
fi

# Получаване на размерите на входния и изходния файл в мегабайти
input_file_size=$(du -h "$input_file" | awk '{print $1}')
output_file_size=$(du -h "$output_file" | awk '{print $1}')

# Отпечатване на пълните пътища до входния и изходния файл, както и техните размери в мегабайти на конзолата
echo "Файл на вход: $input_file ($input_file_size )"
echo "Файл на изход: $output_file ($output_file_size )"
exit
# ################ Инструкции на Български ##################

# Направете скрипта изпълним, като изпълните следния екип:
# chmod +x resize_pdf_BG.sh
# Изпълнете скрипта, като предадете пътя към PDF файла, 
# който искате да преоразмерите като аргумент. 
# Например, за да преоразмерите PDF файла /path/to/input/file.pdf, 
# изпълнете следния script:
# ./resize_pdf_BG.sh /path/to/input/file.pdf
# Скриптът ще ви попита да изберете режим на преоразмеряване.
# Можете да избирате от следните опции:

# Екран (72 dpi)

# Е-книга (150 dpi)

# Принтер (300 dpi)

# Предпечат (300 dpi, запазва цвета)

# По подразбиране (почти идентично на Е-книга)

# Скриптът след това ще преоразмери PDF файла и ще създаде нов PDF файл, наречен /path/to/input/file_small.pdf.

# Скриптът също така ще отпечата пълните пътища до входния и изходния файл, 
# както и техните размери в мегабайти на конзолата.
