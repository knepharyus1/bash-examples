#!/bin/bash

FILE=""
PASSWD=""
OUTPUTDIR=""

usage() {
cat <<EOF
  ERROR: $1

  Usage: cmd-opts <[opts]>
  Options:
    -d  output directory
    -f  input file
    -p  password
EOF
}

while getopts :hd:f:p: opt; do
  case $opt in
    h)
      usage
      ;;
    f)
      FILE=$OPTARG
      if [[ ! -f $FILE ]]; then
        echo "file $FILE does not exist"
        exit 1
      fi
      ;;
    p)
      PASSWD=$OPTARG
      ;;
    d)
      OUTPUTDIR=$OPTARG
      if [[ ! -d $OUTPUTDIR ]]; then
        echo "director $OUTPUTDIR does not exist"
        exit 1
      fi
      ;;
    \?)
      echo "invalid option: -$OPTARG"
      usage
      ;;
  esac
done

if [[ $FILE == "" ]] || [[ ! -f $FILE ]]; then
  usage "no valid file provided"
  exit 1
fi

if [[ $OUTPUTDIR == "" ]] || [[ ! -d $OUTPUTDIR ]]; then
  usage "no valid output directory provided"
  exit 1
fi

while read line; do
  echo "the line is $line..."
done < $FILE
