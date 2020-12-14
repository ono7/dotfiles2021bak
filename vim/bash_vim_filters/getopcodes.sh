#!/bin/bash

read -r instructions

echo $instructions

  ori=$$
  ori_obj=$ori.o
  ori_file=$ori.nasm
  ori_bin=$ori.bin

echo "[BITS 32]" >  $ori_file
echo "[SECTION .text]" >> $ori_file

echo "global _start" >> $ori_file

echo "_start:" >> $ori_file
echo "$instructions" >> $ori_file

  nasm -f elf32 -o $ori_obj $ori_file

  if [[ $? -ne 0 ]]; then
    echo '[ ERROR ]'
    rm $ori_obj
    rm $ori_file
    exit 1;
  fi

  # linker
  ld -o $ori_bin $ori_obj

  if [[ $? -ne 0 ]]; then
    echo '[ ERROR ]'
    exit 1;
  fi

  # clean up
  if [ -e $ori_obj ]; then
    rm $ori_obj
    rm $ori_file
  fi

  echo  '[  Done! ]'
  echo " "
  echo "hexified: "
  echo "$(objdump -d $ori_bin -M intel)"
  echo "\"$(objdump -d $ori_bin | grep '[0-9a-f]:' | cut -d$'\t' -f2 | grep -v 'file' | tr -d " \n" | sed 's/../\\x&/g')\""
  echo " "
  echo "binary_copy_paste:"
  echo "$(objdump -d $ori_bin | grep '[0-9a-f]:' | cut -d$'\t' -f2 | grep -v 'file' | tr -d " \n" )"
  echo " "
  rm $ori_bin

