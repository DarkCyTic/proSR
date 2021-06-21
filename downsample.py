from PIL import Image 
import PIL 

BASE_DIR = '/Users/ege/Desktop/DataSets/'
DIRECTORIES = ['Set5', 'Set14', 'Urban100', 'BSD100', 'Celeba_HQ']
SCALES = [2, 3, 4, 8]

def load_images_from_folder(folder):
  images = []
  
  for filename in os.listdir(folder):
    img = Image.open(folder + "/" + filename)
    #img = cv2.imread(os.path.join(folder,filename))
    if img is not None:
      images.append(img)
  return images


def downsample():
  for directory in DIRECTORIES:
    images = load_images_from_folder(BASE_DIR + directory + '/HR')
    for scale in SCALES: 
      disk_dir = BASE_DIR + directory + "/LR/" + str(scale) + "_b/"
      for i, oriimg in enumerate(images): 
        width, height = oriimg.size
        img = oriimg.resize((int(width/scale), int(height/scale)), Image.BICUBIC)
        
        img.save(disk_dir +str(i) + ".png", "PNG")
        print(img.size)


if __name__ == "__main__":
  downsample()
