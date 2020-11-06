import React, { Component } from "react";
import umbrella_image from '/Users/Martin Tran/clock/src/components/logos/umbrella.png';
import Rain_logo from '/Users/Martin Tran/clock/src/components/logos/Rain.jpg'
import Mostly_Sunny_logo from '/Users/Martin Tran/clock/src/components/logos/Mostly_Sunny.jpg'
import Mostly_Cloudy_logo from '/Users/Martin Tran/clock/src/components/logos/Mostly_Cloudy.jpg'


//API KEY FOR THE WEATHER KEY: 
const api = {
    key: "3e32e02d923cca41c29a63ce60253bc4",
  }

  const icon = {
    rain: Rain_logo,
    sunny: Mostly_Sunny_logo, 
    cloud: Mostly_Cloudy_logo
  }

//The significance of this function is to help choose an icon based on the current weather: 
function Weather_icon_selector(check) {
  if(check == 'Clouds') {
    return icon.cloud
  }
  else if (check == 'Clear'){
    return icon.sunny
  }
  else if (check == 'Rain') {
    return icon.rain
  }
}
  

//This function is used to convert the first letter of a string into a capital letter: 
const capitalize = (s) => {
    if (typeof s !== 'string') return ''
    return s.charAt(0).toUpperCase() + s.slice(1)
  }
  

class Weather extends Component {
constructor () {
    super();
    this.state = {
      //Variables for Weather API: 
      temper: undefined,
      precip: undefined, 
      descrip: undefined,
      main_descrip: undefined,
    }
    this.getWeather()
}
    getWeather = async () => {
        const api_call = await fetch(`http://api.openweathermap.org/data/2.5/weather?q=Dandenong&units=metric&APPID=${api.key}`)
        const data = await api_call.json(); 
        this.setState({
          temper: data.main.temp,
          precip: data.main.humidity,
          descrip: data.weather[0].description,
          main_descrip: data.weather[0].main
        })
      }
    render() {
      return (
       <div className = "App">
            <div className="temp"> {Math.round(this.state.temper)} ° </div>
            <div className = "weather"> {capitalize(this.state.descrip)} </div>
            <div className = "precip"> {this.state.precip}% </div>
            <div className="umbrella_logo">
          <img  className = "umbrella" src={umbrella_image}/>
        </div>
        <div className="Icons">
          <img className = "weather_icon" src={Weather_icon_selector(this.state.main_descrip)}/>
        </div>
      </div> 
      );
    }
  }
  
  export default Weather;