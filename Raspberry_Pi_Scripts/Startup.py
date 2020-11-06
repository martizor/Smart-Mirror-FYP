
##Importing modules into the script: ws2812B, asyncio and Picamera module: 
from rpi_ws281x import *
import requests, json
import time
from picamera import PiCamera
from picamera.array import PiRGBArray
from client import *
#from text_to_speech import * 
import asyncio

LED_COUNT = 23
LED_PIN = 18
LED_FREQ_HZ = 800000
LED_DMA = 10
LED_BRIGHTNESS = 128
LED_INVERT = False
LED_CHANNEL = 0

##Initialising LED strip: 
strip = Adafruit_NeoPixel(LED_COUNT,LED_PIN, LED_FREQ_HZ, LED_DMA, LED_INVERT ,LED_BRIGHTNESS, LED_CHANNEL)
strip.begin()

##Function to change the color of the LED --> Inputtting RGB values: 
def change_color(r,g,b):
    for i in range(0,LED_COUNT):
        strip.setPixelColor(i,Color(r,g,b))
        strip.show()
        time.sleep(0.02)

#Function used to extract keywords from voice commands    
def voice_parser(phrase):
    word_list = phrase.split()
    color_keyword = ["red","green","blue","yellow","pink","white","black"]
    camera_keyword = ["camera","on","off"]
    summary_keyword = ["update","summary"]
    temp = []
    for items in word_list:
        if items.lower() in color_keyword:
            command = items
            return command
        elif items.lower() in camera_keyword:
            temp.append(items)
            if (len(temp) == 2):
                command = (temp[0] + " " + temp[1])
                return command
        elif items.lower( ) in summary_keyword:
            command = items
            return command 
        
##Initialising voice_command: 
content = requests.get("http://192.168.0.13:5000/Voice_list")
data = json.loads(content.content)
temp_array = data["Voice"]
voice_message_old = temp_array[0]["voice"]

##Initialising camera settings: Full Screen Mirror Mode 
camera = PiCamera()
camera.rotation = 270
camera_logic = True
check = 1
flag = 1
print("Running.....")

##Asynchronous function: Used to check user voice reqeusts even if gesture script is being run
## The basic idea is that test_function and gesture function will take turns in running.
## If there is no new voice commands being detected the gesture script will run.
## Likewise with the gesture script if there is no gesture being detected the test_function will run 
async def test_function():
    content = requests.get("http://192.168.0.13:5000/Voice_list")
    data = json.loads(content.content)
    temp_array = data["Voice"]
    voice_message_old = temp_array[0]["voice"]
    while True:
            content = requests.get("http://192.168.0.13:5000/Voice_list")
            data = json.loads(content.content)
            temp_array = data["Voice"]
            new_voice_message = temp_array[0]["voice"]
            if (voice_message_old != new_voice_message):
                command = voice_parser(new_voice_message)
                if (command != None): 
                    if (command.lower() == "blue"):
                        print("Turning blue") 
                        change_color(0,0,255)
                    elif (command.lower() == "green"):
                        print("Turning Green") 
                        change_color(0,255,0)
                    elif (command.lower() == "red"):
                        print("Turning red") 
                        change_color(255,0,0)
                    elif (command.lower() == "pink"):
                        print("Turning Pink") 
                        change_color(255,192,203)
                    elif (command.lower() == "white"):
                        print("Turning white") 
                        change_color(255,255,255)
                    elif (command.lower() == "black"):
                        print("Turning black") 
                        change_color(0,0,0)
                    elif (command.lower() == "summary" or command.lower() == "update"):
                        summary() 
                    elif (command.lower() == "camera on" or command.lower() == "on camera"):
                        ##If a user opts to turn on the camera on the co-routines will stop 
                        camera_logic = True
                        loop.stop()
                        asyncio.sleep(1)
                        loop.close()
                   
            voice_message_old = new_voice_message
            await asyncio.sleep(3)

##Initialising co-routines and ensuring that they loop forever 
loop = asyncio.get_event_loop()
loop.create_task(client_socket(camera,check))
loop.create_task(test_function())
          
##This is the main loop:
##When the Pi is booted up the Pi will be in camera mode
##While in camera mode the user will be able to change the color of the lights
## If the user wants to exit out of camera mode they need to say "camera off"
## Once the camera is turned off the two co-routienes test_function and the gesture function
## will loop forever until the camera is turned on again .

print("Camera On")
camera.start_preview()
while True:
    content = requests.get("http://192.168.0.13:5000/Voice_list")
    data = json.loads(content.content)
    temp_array = data["Voice"]
    new_voice_message = temp_array[0]["voice"]
    if (voice_message_old != new_voice_message):
        command = voice_parser(new_voice_message)
        if (command != None):
            print(command)
            if (command.lower() == "blue"):
                change_color(0,0,255)
                print("Turning Blue") 
            elif (command.lower() == "green"):
                change_color(0,255,0)
                print("Turning Green") 
            elif (command.lower() == "red"):
                change_color(255,0,0)
                print("Turning Red") 
            elif (command.lower() == "pink"):
                print("Turning Pink") 
                change_color(255,192,203)
            elif (command.lower() == "white"):
                print("Turning white") 
                change_color(255,255,255)
            elif (command.lower() == "black"):
                print("Turning Black") 
                change_color(0,0,0)
            elif (command.lower() == "summary" or command.lower() == "update"):
                summary() 
            elif (command.lower() == "camera off" or command.lower() == "off camera"):
                print("Camera turning off") 
                camera_logic = False
                camera.stop_preview()
                loop = asyncio.get_event_loop()
                if (flag >= 2):
                    loop.create_task(client_socket(camera,2))
                else:
                    loop.create_task(client_socket(camera,1))

                loop.create_task(test_function())
                loop.run_forever()
            elif (command.lower() == "camera on" or command.lower() == "on camera"):
                camera.start_preview()
                print("camera on")
                flag += 1
                
        else:
            continue      
            
    voice_message_old = new_voice_message
    time.sleep(5)
'''   
while True:
    red = input("Enter Red Brightness: ")
    blue = input("Enter Blue Brightness: ")
    green = input("Enter Green Brigthness: " )
    change_color(int(red),int(green),int(blue))
    check = input("Would you like to continue?")
    if (check == "y"):
        continue
    else:
        change_color(0,0,0)
        break

'''


            
