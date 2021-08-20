import os
from pathlib import Path
from argparse import ArgumentParser
from math import floor
from PIL import Image


def downscale_by_ratio(img, ratio, method=Image.BICUBIC, magic_crop=False):
    if ratio == 1: return img

    w, h = img.size
    if magic_crop:
        img = img.crop((0, 0, w - w % ratio, h - h % ratio))
        w, h = img.size

    w, h = floor(w / ratio), floor(h / ratio)
    return img.resize((w, h), method)


def parse_args():
    parser = ArgumentParser(description='Downscale')
    parser.add_argument('-i', '--input', help='Input directory')

    args = parser.parse_args()

    return args


if __name__ == '__main__':

    # Parse command-line arguments
    args = parse_args()

    directory_contents = os.listdir(args.input)

    for item in directory_contents:
        subdirectory = os.path.join(args.input, item)
        if os.path.isdir(subdirectory):
            subdirectory_hr = os.path.join(subdirectory, 'HR')
            subdirectory_lr = os.path.join(subdirectory, 'LR')

            two_x_lr = os.path.join(subdirectory_lr, '2x')
            four_x_lr = os.path.join(subdirectory_lr, '4x')
            eight_x_lr = os.path.join(subdirectory_lr, '8x')

            Path(two_x_lr).mkdir(parents=True, exist_ok=True)
            Path(four_x_lr).mkdir(parents=True, exist_ok=True)
            Path(eight_x_lr).mkdir(parents=True, exist_ok=True)

            hr_images = os.listdir(subdirectory_hr)

            for hr_image in hr_images:
                path_to_hr_image = os.path.join(subdirectory_hr, hr_image)
                if os.path.isfile(path_to_hr_image):
                    img = Image.open(path_to_hr_image)

                    # 2x
                    img_scaled = downscale_by_ratio(img, 2)
                    two_x_path = os.path.join(two_x_lr, hr_image)
                    img_scaled.save(two_x_path)

                    # 4x
                    img_scaled = downscale_by_ratio(img, 4)
                    four_x_path = os.path.join(four_x_lr, hr_image)
                    img_scaled.save(four_x_path)

                    # 8x
                    img_scaled = downscale_by_ratio(img, 8)
                    eight_x_path = os.path.join(eight_x_lr, hr_image)
                    img_scaled.save(eight_x_path)
