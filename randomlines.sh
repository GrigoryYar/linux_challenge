#!/bin/bash

# Check arguments and some kind of help
[[ $# -lt 2 ]] && echo "Usage: $0 filename max_size_in_bytes" && exit 1
FILE=$1
bytes_max=$2

# Check file existens
# "Yes" means uppend to the file
[[ -f $1 ]] && echo "File exists !!!" && \
read -p "Continue (y/n)? :" -n 1 -r && \
if [ "$REPLY" != "y" ];  then echo ; exit 1; fi

# 
if [[ -f $1 ]] ; then bytes_written=$(wc -c <"$1")
else bytes_written=0
fi
echo
echo "Bytes in file: $bytes_written"

# Fill the string with all possible symbols
for ch in {0..9} {A..Z} {a..z} ; do 
   ascii_all=$ascii_all$ch
done

# Write lines to FILE, maximum size limited
while [[ $bytes_written -lt $bytes_max ]] ; do 
   line=""
   for in_line in {1..15}
   do
	line=$line${ascii_all:$(($RANDOM%62)):1}
   done

   echo $line >> $FILE
   bytes_written=$[ $bytes_written + 16 ]
done

lines_nb=$(wc -l <$FILE)
echo "Lines in file "$FILE" - $lines"

# Sorting and writing in new file
sort $FILE | sed -n '/^[^Aa]/p' > $FILE".mod"
mod_lines_nb=$(wc -l <$FILE".mod")
echo "Lines deleted: $[ $lines_nb - $mod_lines_nb]"

