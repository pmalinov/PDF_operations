#!/bin/bash
# rev. 1.0 # pmalinov

# Check parameters
if [ $# -ne 1 ]; then
  echo "Error: Please specify the path to the PDF file to resize."
  exit 1
fi

# Read the path to the PDF file
input_file=$1

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

# Run the command
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
exit
############################# Instructions in English ##############################

# Make the script executable by running the following command:
# chmod +x resize_pdf_EN.sh

# Run the script by passing the path to the PDF file you want to resize as an argument. 
# For example, to resize the PDF file /path/to/input/file.pdf, run the following command:
# ./resize_pdf_EN.sh /path/to/input/file.pdf
# The script will prompt you to select a resizing mode. You can choose from the following options:

# Screen (72 dpi)

# Ebook (150 dpi)

# Printer (300 dpi)

# Prepress (300 dpi, preserves color)

# Default (almost identical to Ebook)

# The script will then resize the PDF file 
# and create a new PDF file named /path/to/input/file_small.pdf.

# The script will also print the full paths of the input and output files, 
# as well as their sizes in megabytes, to the console.

