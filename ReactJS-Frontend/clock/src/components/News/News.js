import React, { Component } from "react";

//Global Variable for News Component: 
var temp1 = 1; 
var temp2 = 2;
var temp3 = 3; 



//API KEY FOR NEWS HEADLINES: 
const news_data = { 
    key: "0495eb2367b94929b99691c584579b4f",
  }
 

class News extends Component {
constructor () {
    super();
    this.state = {
      //Variables for News API: 
      content_1: undefined,
      content_2: undefined,
      content_3: undefined,
    }
    this.getNews();
    //News Headlines are obtained every 5 minutes: 
    setInterval(this.getNews, 300000); 

}
    //Asynchronous Function 3: Used to get News Headlines: 
  getNews = async () => {
    const api_call_news = await fetch(`http://newsapi.org/v2/top-headlines?country=au&apiKey=${news_data.key}`)
    const data_news = await api_call_news.json();
    var length_list = (data_news.articles).length - 3
    if (temp1 >= length_list || temp2 >= length_list|| temp3 >= length_list)
      {
      temp1 = 1
      temp2 = 2
      temp3 = 3
    }
    else {
      temp1 = temp1 + 1; 
      temp2 = temp2 + 2;
      temp3 = temp3 + 3; 
    }
    
    this.setState({
      content_1: data_news.articles[temp1].title != null ? data_news.articles[temp1].title : '',
      content_2: data_news.articles[temp2].title != null ? data_news.articles[temp2].title : '',
      content_3: data_news.articles[temp3].title != null ? data_news.articles[temp3].title : '',
    })
  }
    render() {
      return (
       <div className = "App">
          <div className="News-Title">News Headlines:</div>
            <div className="Content1">{this.state.content_1} </div>
            <div className="Content2">{this.state.content_2} </div>
            <div className="Content3">{this.state.content_3} </div>
      </div> 
      );
    }
  }
  
  export default News;