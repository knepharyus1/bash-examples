#!/bin/bash

FILE=""
PASSWD=""
OUTPUTDIR=""

while getopts :hf:p:d: opt; do
  case $opt in
    h)
      usage
      ;;
    f)
      FILE=$OPTARG
      if [ ! -f $FILE ]
      then
        echo "file $FILE does not exist"
        exit 1
      fi
      ;;
    p)
      PASSWD=$OPTARG
      ;;
    d)
      OUTPUTDIR=$OPTARG
      if [ ! -d $OUTPUTDIR ]
      then
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

usage() {
  cat <<EOF
    cmd-opts $opts
    $*
        Usage: cmd-opts <[opts]>
        Options:
                -d  output directory
                -f  input file
                -p  password
  EOF
}
