import React, { Component } from "react";
import down_arrow_check from '/Users/Martin Tran/clock/src/components/Stocks/stock_icons/down.png'
import up_arrow from '/Users/Martin Tran/clock/src/components/Stocks/stock_icons/up.png' 
import black_img from '/Users/Martin Tran/clock/src/components/Time_commute/transport_icons/black_img.jpg'


//Global Variable for News Component: 
var flag = 0 

function pos_neg_decider(string) {
    if (string != null) {
    string = string.replace("(","")
    string = string.replace(")","")
    string = string.replace("%","")

    var float = parseFloat(string)
    if (float < 0) {
        return "red"
    }
    else {
        return "green"
    }
}
else {
    return ""
}
}


class Stock extends Component {
constructor () {
    super();
    this.state = {
        stock_name1: undefined,
        stock_price1: undefined,
        stock_percent1: undefined, 
        stock_name2: undefined,
        stock_price2: undefined,
        stock_percent2: undefined, 
        stock_name3: undefined,
        stock_price3: undefined,
        stock_percent3: undefined, 
        stock_name4: undefined,
        stock_price4: undefined,
        stock_percent4: undefined, 
        percent_color1: undefined,
        percent_color2: undefined, 
        percent_color3: undefined, 
        percent_color4: undefined 
          
    }
    this.getStock();
    setInterval(this.getStock,1000)
}
    getStock = async () => {
        const api_call_stock = await fetch(`/stock_list`)
        const data_stock = await api_call_stock.json();
        this.setState({
            stock_name1: (data_stock["Stock"][0] != null ? data_stock["Stock"][0]["stock_name"] + ":" : "No added stocks to Added!"), 
            stock_price1: (data_stock["Stock"][0] != null ? data_stock["Stock"][0]["stock_price"] + " " + "AUD" : ""), 
            stock_percent1: (data_stock["Stock"][0] != null ? "(" + data_stock["Stock"][0]["stock_percent"] + ")": ""),
            stock_name2: (data_stock["Stock"][1] != null ? data_stock["Stock"][1]["stock_name"] + ":" : ""), 
            stock_price2: (data_stock["Stock"][1] != null ? data_stock["Stock"][1]["stock_price"] + " " + "AUD" : ""), 
            stock_percent2: (data_stock["Stock"][1] != null ? "(" + data_stock["Stock"][1]["stock_percent"] + ")": ""), 
            stock_name3: (data_stock["Stock"][2] != null ? data_stock["Stock"][2]["stock_name"] + ":" : ""), 
            stock_price3: (data_stock["Stock"][2] != null ? data_stock["Stock"][2]["stock_price"] + " " + "AUD" : ""), 
            stock_percent3: (data_stock["Stock"][2] != null ? "(" + data_stock["Stock"][2]["stock_percent"] + ")" : ""), 
            stock_name4: (data_stock["Stock"][3] != null ? data_stock["Stock"][3]["stock_name"] + ":": ""), 
            stock_price4: (data_stock["Stock"][3] != null ? data_stock["Stock"][3]["stock_price"] + " " + "AUD" : ""), 
            stock_percent4: (data_stock["Stock"][3] != null ? "(" +  data_stock["Stock"][3]["stock_percent"] + ")" : ""), 
            percent_color1: (data_stock["Stock"][0]!=null ? pos_neg_decider(this.state.stock_percent1): "" ),
            percent_color2: (data_stock["Stock"][1]!=null ? pos_neg_decider(this.state.stock_percent2): "" ),
            percent_color3: (data_stock["Stock"][2]!=null ? pos_neg_decider(this.state.stock_percent3): "" ),
            percent_color4: (data_stock["Stock"][3]!=null ? pos_neg_decider(this.state.stock_percent4): "" ),


        })
      }
    render() {
      return (
       <div className = "App">
       <div className="Stock-Title">Stocks Watchlist </div>
       <div className="arrow-logo">
          <img  className = "arrow1" src={this.state.stock_percent1!="" ? (pos_neg_decider(this.state.stock_percent1)== "red" ?  down_arrow_check:up_arrow):black_img}/>
        </div>
      <div className="Stock1"> <b>{this.state.stock_name1}</b>{this.state.stock_price1}<b style={{color: this.state.percent_color1}}>{this.state.stock_percent1}</b></div>
      <div className="arrow-logo">
          <img  className = "arrow2" src={this.state.stock_percent2!="" ? (pos_neg_decider(this.state.stock_percent2)== "red" ?  down_arrow_check:up_arrow):black_img}/>
        </div>
      <div className="Stock2"> <b>{this.state.stock_name2}</b>{this.state.stock_price2}<b style={{color: this.state.percent_color2}}>{this.state.stock_percent2}</b></div>
      <div className="arrow-logo">
          <img  className = "arrow3" src={this.state.stock_percent3!="" ? (pos_neg_decider(this.state.stock_percent3)== "red" ?  down_arrow_check:up_arrow):black_img}/>
        </div>
      <div className="Stock3"> <b>{this.state.stock_name3}</b>{this.state.stock_price3}<b style={{color: this.state.percent_color3}}>{this.state.stock_percent3}</b></div>
      <div className="arrow-logo">
          <img  className = "arrow4" src={this.state.stock_percent4!="" ? (pos_neg_decider(this.state.stock_percent4)== "red" ?  down_arrow_check:up_arrow):black_img}/>
        </div>
      <div className="Stock4"> <b>{this.state.stock_name4}</b>{this.state.stock_price4}<b style={{color: this.state.percent_color4}}>{this.state.stock_percent4}</b></div>
      </div> 
      
      );
    }
  }
  
  export default Stock;