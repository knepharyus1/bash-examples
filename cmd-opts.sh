#!/bin/bash

FILE=""
PASSWD=""
DIR=""

usage() {

  if [[ $1 != "" ]]; then
    echo "  ERROR: $1"
  fi

cat <<EOF

  Usage: $0 <[opts]>
  Options:
    -d  output directory
    -f  input file
    -h  display this help dialog
    -p  password
EOF

  exit 0
}

while getopts :hd:f:p: opt; do
  case $opt in
    h)
      usage
      ;;
    f)
      FILE=$OPTARG
      ;;
    p)
      PASSWD=$OPTARG
      ;;
    d)
      DIR=$OPTARG
      ;;
    \?)
      echo "invalid option: -$OPTARG"
      usage
      ;;
  esac
done

# Check for the existence of a file
if [[ $FILE == "" ]] || [[ ! -f $FILE ]]; then
  usage "no valid file provided"
  exit 1
fi

# Check for the existence of a directory
if [[ $DIR == "" ]] || [[ ! -d $DIR ]]; then
  usage "no valid output directory provided"
  exit 1
fi

# Loop over lines in a file
while read line; do
  echo "the line is $line..."

  # Loop over words in a line
  # Same as looping through array items
  for word in $line; do
    echo "the word is $word..."
  done

done < $FILE

# Loop through contents of a directory
for item in $(ls $DIR)
do
  echo "I found $item..."
done
