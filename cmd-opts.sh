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

## Loop through contents of a directory
for item in $(ls $DIR)
do
  echo "I found $item..."
done

## Loop over a comma-separated list
$list="foo,bar,baz"
for item in $(echo $list | sed "s/,/ /g")
do
  echo $item
done

## Create an array. Also, increment a number variable
count=0
declare -A arr

for item in $(echo $list | sed "s/,/ /g")
do
  arr+=( [$item]="entry number $count" )
  ((count++))
done

for key in ${!arr[@]}
do
  echo "${key} is ${arr[${key}]}"
done

## Create a file with variable replacement enabled
cat > /path/to/file.txt <<EOF
line 1:
line 2: the variable $DIR will be replaced with its assigned value
EOF

## Append to a file with variable replacement disabled
cat >> /path/to/file.txt <<'EOF'
line 3:
line 4: the literal string $DIR will be written to the file, not the assigned value
EOF

## Append to a file with variable replacement enabled,
## but also allowing inclusion of a variable name.
## This shows that variable replacement is single-level
TEMP='$varname'
cat >> /path/to/file.txt <<EOF
line 5:
line 6: $DIR will be replaced with its assigned value
line 7: $TEMP will as well, by the literal string dollarsignvarname
EOF

## In-place string replacement in a file
sed -i 's/change me/i got changed/' /path/to/file.txt

## In-place string replacement in a file, allowing variable
## replacement, and using alternate separator
sed -i -e "s@path=\"/a/file/path\"@path=\"/a/new/${DIR}\"@" /path/to/file.txt
