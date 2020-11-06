import React, { Component } from "react";

//Global Calendar Variables:
var today = (new Date()).toISOString();
var today_temp = new Date(); 
var tomorrow = new Date(today_temp.getTime() + (24 * 60 * 60 * 1000)).toISOString();
var days = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
var months = new Array('January','February','March','April','May','June','July','August','September','October','November','December');

//API KEY AND CALENDAR KEY: 
const data_calendar = {
    key: "AIzaSyBzvvThTFkeDDcgk_sjgiNWi23kg1wYtF4",
    calendar_id: "diam4np9tr6e7gs04od30otbb0@group.calendar.google.com"
  }

//This function is used to convert an ISOstring format into a more readable and concise format: 
const date_formatter = (s) => {
    if (typeof s !== 'string') return ''
    if (s.substring(0,10) == today.substring(0,10)) {
      return (parseInt(s.substring(11,13)) > 12) ? ("Today -" + " " + (parseInt(s.substring(11,13))-12).toString() + s.substring(13,16) + "pm"): ("Today -" + " " + (s.substring(11,16)) + "am")
    }
    else if (s.substring(0,10) == tomorrow.substring(0,10)) {
      return (parseInt(s.substring(11,13)) > 12) ? ("Tomorrow -" + " " + (parseInt(s.substring(11,13))-12).toString() + s.substring(13,16) + "pm"): ("Tomorrow -" + " " + (s.substring(11,16)) + "am")
    }
    else if (s != ''){
      var d = new Date(s); 
      return days[d.getUTCDay()] + " " + "-" + " " + d.getUTCDate() + "th" + " " + months[d.getUTCMonth()];
    } 
    else {
      return ''
    }
  }

  

//This function is used to convert the first letter of a string into a capital letter: 
const capitalize = (s) => {
    if (typeof s !== 'string') return ''
    return s.charAt(0).toUpperCase() + s.slice(1)
  }
  

class Calendar extends Component {
constructor () {
    super();
    this.state = {
     //Variables for Calendar API: 
     calendar_events1: undefined,
     calendar_events_time1: undefined ,
     calendar_events2: undefined,
     calendar_events_time2: undefined ,
     calendar_events3: undefined,
     calendar_events_time3: undefined ,
     calendar_events4: undefined,
     calendar_events_time4: undefined, 
     calendar_events5: undefined,
     calendar_events_time5: undefined, 
     index_length: undefined, 
    }
    this.getEvents()
    //Calendar Events are obtained every 5 seconds: 
    setInterval(this.getEvents, 5000);
}
   //Asynchronous Function 2: Used to calendar events: 
   getEvents = async () => {
    const api_call_calen = await fetch(`https://www.googleapis.com/calendar/v3/calendars/${data_calendar.calendar_id}/events?key=${data_calendar.key}&timeMin=${today}&orderBy=startTime&singleEvents=true`)
    const data_calen = await api_call_calen.json(); 
    this.setState({
      calendar_events1: (data_calen.items[0] != null) ? data_calen.items[0].summary : '',
      calendar_events_time1: data_calen.items[0] != null != 0 ? (data_calen.items[0].start.dateTime) : '',
      calendar_events2: data_calen.items[1] != null ? data_calen.items[1].summary : '',
      calendar_events_time2: data_calen.items[1] != null != 0 ? (data_calen.items[1].start.dateTime) : '',
      calendar_events3: data_calen.items[2] != null ? data_calen.items[2].summary : '',
      calendar_events_time3: data_calen.items[2] != null != 0 ? (data_calen.items[2].start.dateTime) : '',
      calendar_events4: data_calen.items[3] != null ? data_calen.items[3].summary : '',
      calendar_events_time4: data_calen.items[3] != null != 0 ? (data_calen.items[3].start.dateTime) : '',
      calendar_events5: data_calen.items[4] != null ? data_calen.items[4].summary : '',
      calendar_events_time5: data_calen.items[4] != null != 0 ? (data_calen.items[4].start.dateTime) : '',
      index_length: (data_calen.items).length
    })
  }
    render() {
      return (
       <div className = "App">
          <div className="Title"> Schedule </div>
          <div className="Event"> {(this.state.index_length != 0) ? capitalize(this.state.calendar_events1) : "Nothing Scheduled"} </div>
          <div className="Event2">  {date_formatter(this.state.calendar_events_time1)} </div>
          <div className="Event"> {capitalize(this.state.calendar_events2)} </div>
          <div className="Event2">  {date_formatter(this.state.calendar_events_time2)} </div>
          <div className="Event"> {capitalize(this.state.calendar_events3)} </div>
          <div className="Event2">  {date_formatter(this.state.calendar_events_time3)} </div>
          <div className="Event"> {capitalize(this.state.calendar_events4)} </div>
          <div className="Event2">  {date_formatter(this.state.calendar_events_time4)} </div>
          <div className="Event"> {capitalize(this.state.calendar_events5)} </div>
          <div className="Event2">  {date_formatter(this.state.calendar_events_time5)} </div>
      </div> 
      );
    }
  }
  
  export default Calendar;