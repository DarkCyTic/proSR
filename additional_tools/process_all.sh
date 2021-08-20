#! /bin/bash

# Example Usage: ./process_all.sh evaluation/input output proSR

# First Argument: Relative path to input folder containing all datasets
# Second Argument: Relative path to output folder
# Third Argument: Model name

DATADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#declare -a DATASETS=('BSD100' 'Celeba_HQ' 'Set5' 'Set14' 'Urban100')
declare -a DATASETS=('animals' 'art' 'astronomy' 'faces' 'indoors' 'nature' 'urban')
declare -a SAMPLING_FACTORS=('2x' '4x' '8x')

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
      "2" | "2_b" | "2x")
        # Command for 2x upsampling (modify for your own model)
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 2 --cpu --output-dir $output_folder
        ;;

      "3" | "3_b" | "3x")
        # Command for 3x upsampling (modify for your own model)
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 3 --cpu --output-dir $output_folder
        ;;

      "4" | "4_b" | "4x")
        # Command for 4x upsampling (modify for your own model)
        python test.py -i $input_folder --checkpoint data/checkpoints/$3.pth --scale 4 --cpu --output-dir $output_folder
        ;;

      "8" | "8_b" | "8x")
        # Command for 8x upsampling (modify for your own model)
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
