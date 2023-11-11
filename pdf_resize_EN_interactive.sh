#!/bin/bash

# rev. 1.0 # pmalinov

# Prompt the user for the path to the PDF file
echo "Enter the path to the PDF file you want to resize:"
read input_file

# Get the directory of the input file
input_file_dir=$(dirname "$input_file")

# Get the full path of the output file
output_file="${input_file%%.*}_small.pdf"

# Ask the user for the resizing mode
echo "Which resizing mode do you want to use?"
echo "1. Screen (72 dpi)"
echo "2. Ebook (150 dpi)"
echo "3. Printer (300 dpi)"
echo "4. Prepress (300 dpi, preserves color)"
echo "5. Default (almost identical to Ebook)"

read -p "Select a mode (1-5): " option

# Compose the resizing command
dpi_setting=""
case $option in
  1) dpi_setting="-dPDFSETTINGS=/screen" ;;
  2) dpi_setting="-dPDFSETTINGS=/ebook" ;;
  3) dpi_setting="-dPDFSETTINGS=/printer" ;;
  4) dpi_setting="-dPDFSETTINGS=/prepress" ;;
  5) dpi_setting="-dPDFSETTINGS=/default" ;;
esac

# Resize the file to the temporary file
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 $dpi_setting -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file

# Check the outcome of the operation
if [ $? -ne 0 ]; then
  echo "Error resizing the PDF file."
  exit 1
fi

# Get the sizes of the input and output files in megabytes
input_file_size=$(du -h "$input_file" | awk '{print $1}')
output_file_size=$(du -h "$output_file" | awk '{print $1}')

# Print the full paths of the input and output files, as well as their sizes in megabytes
echo "Input file: $input_file ($input_file_size )"
echo "Output file: $output_file ($output_file_size )"

# Keep the terminal open until the user presses ENTER
echo "Press ENTER to exit..."
stty -icanon
read -n 1 -s
stty icanon

##########################################
# The script will prompt you to enter the path to the PDF file you want to resize.
# Enter the path to the PDF file and press Enter.
# The script will prompt you to select a resizing mode.
# Select a resizing mode by typing the corresponding number and pressing Enter.
# The script will resize the PDF file and save the output file in the same directory as the input file.
# The script will print the full paths of the input and output files, as well as their sizes in megabytes.
# Press Enter to exit the script.
