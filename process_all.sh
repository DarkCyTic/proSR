#! /bin/bash

# Example Usage: ./process_all.sh evaluation/input output proSR

# First Argument: Relative path to input folder containing all datasets
# Second Argument: Relative path to output folder
# Third Argument: Model name

DATADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a DATASETS=('BSD100' 'Celeba_HQ' 'Set14' 'Urban100')
declare -a SAMPLING_FACTORS=('2' '2_b' '3' '3_b' '4' '4_b' '8' '8_b')

for dataset in "${DATASETS[@]}"
do
  for sampling_factor in "${SAMPLING_FACTORS[@]}"
  do
    echo "Processing $dataset - $sampling_factor"
    input_folder="${DATADIR}/${1}/${dataset}/LR/${sampling_factor}"
    output_folder="${DATADIR}/${2}/${3}/${dataset}/${sampling_factor}"
    # Uncomment next line to dynamically create the necessary output folder
    # mkdir -p $output_folder
    case $sampling_factor in
      "2" | "2_b")
        # Command for 2x upsampling
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 2 --cpu --output-dir $output_folder
        ;;

      "3" | "3_b")
        # Command for 3x upsampling
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 3 --cpu --output-dir $output_folder
        ;;

      "4" | "4_b")
        # Command for 4x upsampling
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 4 --cpu --output-dir $output_folder
        ;;

      "8" | "8_b")
        # Command for 8x upsampling
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 8 --cpu --output-dir $output_folder
        ;;
      *)
        echo "Sampling factor unknown: ${sampling_factor}"
        ;;
    esac
    printf "\n"
  done
  printf "\n\n"
done
