import cv2
import numpy as np
from playsound import playsound
import requests

def post(label):
    API_ENDPOINT = "http://192.168.0.13:5000/gesture_post"
    API_ENDPOINT2 = "http://192.168.0.13:5000/delete_gesture"
    if (label == "love"): 
        requests.post(url = API_ENDPOINT, json = {"gesture":"peace"})
    elif (label == "five"):
        requests.post(url = API_ENDPOINT, json = {"gesture":"five"})
    else:
        requests.post(url = API_ENDPOINT2)

        


def network(): 
    
    net = cv2.dnn.readNet('final.weights', './cfg/final.cfg')

    classes = []
    with open("./data/final.names", "r") as f:
        classes = f.read().splitlines()

    img = cv2.imread("./Images/Image0.jpeg")
    font = cv2.FONT_HERSHEY_PLAIN
    colors = np.random.uniform(0, 255, size=(100, 3))

    height, width, _ = img.shape

    blob = cv2.dnn.blobFromImage(img, 1/255, (416, 416), (0,0,0), swapRB=True, crop=False)
    net.setInput(blob)
    output_layers_names = net.getUnconnectedOutLayersNames()
    layerOutputs = net.forward(output_layers_names)

    boxes = []
    confidences = []
    class_ids = []

    for output in layerOutputs:
        for detection in output:
            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = scores[class_id]
            if confidence > 0.2:
                center_x = int(detection[0]*width)
                center_y = int(detection[1]*height)
                w = int(detection[2]*width)
                h = int(detection[3]*height)

                x = int(center_x - w/2)
                y = int(center_y - h/2)

                boxes.append([x, y, w, h])
                confidences.append((float(confidence)))
                class_ids.append(class_id)

    indexes = cv2.dnn.NMSBoxes(boxes, confidences, 0.2, 0.4)

    if len(indexes)>0:
        for i in indexes.flatten():
            x, y, w, h = boxes[i]
            label = str(classes[class_ids[i]])
            confidence = str(round(confidences[i],2))
            color = colors[i]
            cv2.rectangle(img, (x,y), (x+w, y+h), color, 2)
            cv2.putText(img, label + " " + confidence, (x, y+20), font, 2, (255,255,255), 2)
        post(label)
        cv2.imwrite("./output/Image0.jpeg", img) 
    else:
        post("Nothing")
        cv2.imwrite("./output/Image0.jpeg", img) 
    


network()