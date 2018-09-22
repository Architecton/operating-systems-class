#!/bin/bash
 
while getopts ":a:" opt; do
  case $opt in
    a)
      # >&2: redirect output of echo to stderr.
      # & signals that 2 is a file descriptor.
      echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
dones