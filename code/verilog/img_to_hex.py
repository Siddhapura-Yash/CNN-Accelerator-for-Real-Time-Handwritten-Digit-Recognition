# to create environment => python -m venv opencvenv
# to activate => source opencvenv/bin/activate
# to download opencv libray => pip install opencv-python

import cv2

# read images in grayscale
left_img = cv2.imread("left.png", cv2.IMREAD_GRAYSCALE)
right_img = cv2.imread("right.png", cv2.IMREAD_GRAYSCALE)
# left_img = cv2.imread("im0.png", cv2.IMREAD_GRAYSCALE)
# right_img = cv2.imread("im1.png", cv2.IMREAD_GRAYSCALE)

# get dimensions
height, width = left_img.shape

# generate LEFT hex file
with open("left.hex", "w") as f:

    for r in range(height):
        for c in range(width):

            pixel = left_img[r, c]

            # write pixel row-wise in HEX
            f.write(f"{pixel:02X}\n")

# generate RIGHT hex file
with open("right.hex", "w") as f:

    for r in range(height):
        for c in range(width):

            pixel = right_img[r, c]

            # write pixel row-wise in HEX
            f.write(f"{pixel:02X}\n")

print("left.hex and right.hex generated successfully")