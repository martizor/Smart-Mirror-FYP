import React, { Component, useState, ReactNode, SyntheticEvent, useEffect } from "react";
import "./App.css";
import "./components/Weather/Weather.css"
import "./components/Calendar/Calendar.css"
import "./components/News/News.css"
import "./components/Time_commute/Time_commute.css"
import "./components/gesture/gesture.css"
import "./components/Stocks/stock.css"
import Time from "./components/Clock/Clock";
import Weather from "./components/Weather/Weather";
import Calendar from "./components/Calendar/Calendar"
import News from "./components/News/News"
import Time_commute from "./components/Time_commute/Time_commute"
import Gesture from "./components/gesture/gesture"
import Stock from "./components/Stocks/stock"


class App extends React.Component {

  render() {
    return (
      <div className="App">
        <main>
          <Time/>
      <div ClassName = "Weather_module"> 
          <Weather/>
       </div>
       <div ClassName = "News_module"> 
          <News/>
       </div>
       <div ClassName = "Calendar_module"> 
          <Calendar/>
       </div>
       <div ClassName = "TimeCommute_module"> 
          <Time_commute/>
       </div>
       <div ClassName = "Stock_module"> 
          <Stock/>
       </div>
       <div ClassName = "Gesture_module"> 
          <Gesture/>
       </div>
        </main>
      </div>
    );
  }
}

export default App;
