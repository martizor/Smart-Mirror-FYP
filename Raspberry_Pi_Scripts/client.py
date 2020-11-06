import io
import socket
import struct
import time
import picamera
import asyncio 

# CFonnect a client socket to my_server:8000 (change my_server to the
# hostname of your server)

async def client_socket(camera,check):
# Make a file-resolution = (416,416)
    print(check)
    while(True):
        if (check == 1):
            client_socket = socket.socket()
            client_socket.connect(('192.168.0.37', 8000))
            connection = client_socket.makefile('wb')
     
        # Start a preview and let the camera warm up for 2 seconds

        # Note the start time and construct a stream to hold image data
        # temporarily (we could write it directly to connection but in this
        # case we want to find out the size of each capture first to keep
        # our protocol simple)
        stream = io.BytesIO()
        for foo in camera.capture_continuous(stream, 'jpeg'):
            # Write the length of the capture to the stream and flush to
            # ensure it actually gets sent
            connection.write(struct.pack('<L', stream.tell()))
            connection.flush()
            # Rewind the stream and send the image data over the wire
            stream.seek(0)
            connection.write(stream.read())
            # If we've been capturing for more than 30 seconds, quit

            # Reset the stream for the next capture
            stream.seek(0)
            stream.truncate()
            check = check + 1
            await asyncio.sleep(1)

  
