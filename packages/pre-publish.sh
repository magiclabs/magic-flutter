#!/bin/bash

prepublishCheck (){

  echo "=== Formatting source package $1 ==="
  flutter format "$1"
  tempFolderPath="./$1_copy/"

  echo
  echo "=== Start prepublish check $1 ==="

  cp -r "./$1" "$tempFolderPath"
  dart pub global run pana "$tempFolderPath"
  rm -r "$tempFolderPath"

  echo
  echo "=== Prepublish Check for $1 is completed! === "
  echo
}

PS3='Please select the package to be checked: '
options=("magic_sdk" "magic_ext/oauth" "magic_ext/tezos" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "magic_sdk")
            prepublishCheck "$opt"
            break
            ;;
        "magic_ext/oauth")
            prepublishCheck "$opt"
            break
            ;;
        "magic_ext/tezos")
            prepublishCheck "$opt"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
