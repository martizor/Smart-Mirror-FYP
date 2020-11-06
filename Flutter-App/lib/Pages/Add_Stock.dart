import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  String STOCK_KEY = '131SK0HW0CSAWYSL';
  String stock_price;
  String percent_change;
  List<String> stock_list = [];
  Map data = {};


  //Function here is used to access the stock API and grab the current stock price and percent change:
  void Add_get_Stock(String stock) async {
    String url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$stock&apikey=$STOCK_KEY";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    stock_price = values["Global Quote"]["05. price"];
    percent_change = values["Global Quote"]["10. change percent"];
    var url2 = "http://192.168.0.13:5000/stock_post";
    var body = json.encode({"stock_name": stock ,"stock_price":stock_price,"stock_percent":percent_change});
    var response2 = await http.post(url2, headers: {"Content-Type": "application/json"},body: body);
    print('Response status: ${response2.statusCode}');
    print('Response body: ${response2.body}');
  }

  void remove_stock(String Stock) async {
    var url = "http://192.168.0.13:5000/delete_stock";
    var body = json.encode({"stock_name":Stock});
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }


  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build (BuildContext ctxt) {
    data = ModalRoute.of(context).settings.arguments;
    stock_list = data["Stocks"];
    return new Scaffold(
        appBar: new AppBar(title: new Text("Stocks",
          style: TextStyle(
              fontFamily: 'Robotomono'
          ),),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushReplacementNamed(context, '/Modules')
          ),),
        body: new Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              decoration: InputDecoration(hintText: "Enter Stock Initials"),
              onSubmitted: (text) {
                stock_list.add(text);
                eCtrl.clear();
                setState(() {
                  Add_get_Stock(text);
                });
              },
            ),
            new Expanded(
                child: new ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: stock_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = stock_list[index];

                    return Dismissible(
                      key: Key(item),
                      // Provide a function that tells the app
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          remove_stock(stock_list[index]);
                          stock_list.removeAt(index);
                        });
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("$item dismissed")));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      child: ListTile(title: Text('$item',
                        style: TextStyle(
                            fontFamily: 'Robotomono',
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
            )
          ],
        )
    );
  }
}