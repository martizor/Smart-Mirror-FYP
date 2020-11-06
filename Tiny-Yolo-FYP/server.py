import io
import socket
import struct
from PIL import Image
import matplotlib.pyplot as pl
import time 
from Object_Detection import *

server_socket = socket.socket()
server_socket.bind(('192.168.0.37', 8000))  # ADD IP HERE
server_socket.listen(0)
directory = "./Images"
# Accept a single connection and make a file-like object out of it
connection = server_socket.accept()[0].makefile('rb')
count = 0
try:
    img = None
    while True:
        # Read the length of the image as a 32-bit unsigned int. If the
        # length is zero, quit the loop
        image_len = struct.unpack('<L', connection.read(struct.calcsize('<L')))[0]
        print("Working")
        if not image_len:
            break
        # Construct a stream to hold the image data and read the image
        # data from the connection
        image_stream = io.BytesIO()
        image_stream.write(connection.read(image_len))
        # Rewind the stream, open it as an image with PIL and do some
        # processing on it
        image_stream.seek(0)
        image = Image.open(image_stream)
        image = image.rotate(270)
        image = image.resize((416,416))

        image.save(directory + "/" + 'Image0.jpeg','JPEG')
        network()
        

finally:
    print("Nothing")