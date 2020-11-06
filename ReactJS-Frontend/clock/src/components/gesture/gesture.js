import React, { Component } from "react";
import peace from '/Users/Martin Tran/clock/src/components/gesture/GIFS/finger_heart.gif'
import black_img from '/Users/Martin Tran/clock/src/components/Time_commute/transport_icons/black_img.jpg'
import five from '/Users/Martin Tran/clock/src/components/gesture/GIFS/high_five.gif'

function GIF_decider(value) {
    if (value == "peace") {
        return peace
    }
    else if (value == "five") {
        return five
    }
    else {
        return black_img
    }
}

class Gesture extends Component {
constructor () {
    super();
    this.state = {
        gesture: undefined 
    }
    this.getGesture();
    setInterval(this.getGesture,5000)
}
    getGesture = async () => {
        const api_call_gesture = await fetch(`/gesture_list`)
        const data_gesture = await api_call_gesture.json();
        this.setState({
           gesture: data_gesture["Gestures"][0] != null ? data_gesture["Gestures"][0]["gesture"] : ""
        })
      }
      
    render() {
      return (
       <div className = "App">
          <div className="GIF">
          <img  className = "Gesture_Gif" src={GIF_decider(this.state.gesture)}/>
        </div>
      </div> 
      );
    }
  }
  
  export default Gesture;