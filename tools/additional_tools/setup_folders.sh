#! /bin/bash

# Example Usage: ./setup_folders.sh output

# First Argument: Relative path to subfolder

DATADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a DATASETS=('BSD100' 'Celeba_HQ' 'Set5' 'Set14' 'Urban100')
declare -a SAMPLING_FACTORS=('2_b' '4_b' '8_b')

for dataset in "${DATASETS[@]}"
do
  for sampling_factor in "${SAMPLING_FACTORS[@]}"
  do
    echo "Creating $dataset/$sampling_factor"
    mkdir -p $DATADIR/$1/$dataset/$sampling_factor
  done
  printf "\n"
done
