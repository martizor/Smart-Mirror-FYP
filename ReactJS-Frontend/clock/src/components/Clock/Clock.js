import React, { Component } from "react";
import Clock from 'react-live-clock'
import "./Clock.css"
import moment from "moment";


class Time extends Component {
  constructor () {
    super();
    this.state = {
     time_mode: undefined
    }
    this.time_mode();
    setInterval(this.time_mode,1000)
 
}
    time_mode = async () => {
        const api_call_time = await fetch(`/24_hour_list`)
        const data_time = await api_call_time.json();
        this.setState({
          time_mode: (data_time["24 Hour Time"][0]["time_mode"] == "OFF") ? "hh:mm A":"HH:mm A",
        })
      }
 
  render() {
    return (
     <div className = "App">
      <div className="Time">
          {moment().format(this.state.time_mode)} {}
         </div>
         <div className = "Day"> 
          {moment().format('dddd')}
         </div>
         <div className = "Month"> 
          {moment().format('MMMM Do')}
         </div>
    </div> 
    );
  }
}

export default Time;
