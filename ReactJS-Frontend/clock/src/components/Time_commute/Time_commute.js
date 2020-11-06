import React, { Component } from "react";
import car_logo from '/Users/Martin Tran/clock/src/components/Time_commute/transport_icons/car_icon.png'
import black_img from '/Users/Martin Tran/clock/src/components/Time_commute/transport_icons/black_img.jpg'
//Global Variable for News Component: 
var flag = 0 



class Time_Commute extends Component {
constructor () {
    super();
    this.state = {
     commute_place1:undefined, 
     commute_place2:undefined,
     commute_place3:undefined,
     commute_place4:undefined,
     commute_time1:undefined, 
     commute_time2:undefined, 
     commute_time3:undefined, 
     commute_time4:undefined, 

    }
    this.getCommute();
    setInterval(this.getCommute,5000)
}
    getCommute = async () => {
        const api_call_commute = await fetch(`/time_commute_list`)
        const data_commute = await api_call_commute.json();
        this.setState({
          commute_place1: (data_commute["commutes"][0] != null) ? "Drive to" + " " + data_commute["commutes"][0]["name"] + " " + "-":" No Commute Times Added!",
          commute_place2: (data_commute["commutes"][1] != null) ? "Drive to" + " " + data_commute["commutes"][1]["name"]+ " " + "-":"",
          commute_place3: (data_commute["commutes"][2] != null) ? "Drive to" + " " + data_commute["commutes"][2]["name"]+ " " + "-":"",
          commute_place4: (data_commute["commutes"][3] != null) ? "Drive to" + " " + data_commute["commutes"][3]["name"]+ " " + "-":"",
          commute_time1: (data_commute["commutes"][0] != null) ? Math.round(data_commute["commutes"][0]["time"]/60) + " " + "Min":"",
          commute_time2: (data_commute["commutes"][1] != null) ? Math.round(data_commute["commutes"][1]["time"]/60)+ " " + "Min":"",
          commute_time3: (data_commute["commutes"][2] != null) ? Math.round(data_commute["commutes"][2]["time"]/60)+ " " + "Min":"",
          commute_time4: (data_commute["commutes"][3] != null) ? Math.round(data_commute["commutes"][3]["time"]/60)+ " " + "Min":"",

        })
      }
      
    render() {
      return (
       <div className = "App">
          <div className="Commute-Title">Commute Time</div>
          <div className="car-logo">
          <img  className = "car1" src={this.state.commute_time1!="" ? car_logo:black_img}/>
        </div>
      <div className="Commute-Time"> {this.state.commute_place1} {this.state.commute_time1} </div>
      <div className="car-logo">
          <img  className = "car2" src={this.state.commute_place2!="" ? car_logo:black_img}/>
        </div>
      <div className="Commute-Time2">{this.state.commute_place2} {this.state.commute_time2} </div>
      <div className="car-logo">
          <img  className = "car3" src={this.state.commute_place3!="" ? car_logo:black_img}/>
        </div>
      <div className="Commute-Time3">{this.state.commute_place3} {this.state.commute_time3} </div>
      <div className="car-logo">
          <img  className = "car4" src={this.state.commute_place4!= "" ? car_logo:black_img}/>
        </div>
      <div className="Commute-Time4"> {this.state.commute_place4} {this.state.commute_time4} </div>
      </div> 
      
      );
    }
  }
  
  export default Time_Commute;