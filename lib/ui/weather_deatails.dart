import 'package:flutter/material.dart';
import  '../util/utils.dart' as util;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherDetails extends StatefulWidget {
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Klimatic',
          style: new TextStyle(color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14.5),),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.menu),onPressed: null)
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('assets/umbrella.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,),
          ),

          new Container(
            child: new Text('Mumbai',
                style: cityStyle()),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
          ),

          new Container(
            child: new Image.asset('assets/light_rain.png'),
            alignment: Alignment.center,
          ),

          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 320.0, 0.0, 0.0),
            child: updateTempWidget("Mumbai"),

          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async{
    String apiUrl = 'http://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=${util.appID}&units=impeial';
    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
}

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.appID, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if(snapshot.hasData){
              Map data = snapshot.data;
              return new Container(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text(data['list']['0']['main']['temp_min'].toString(),
                      style: tempStyle(),),
                    )
                  ],
                ),
              );
            }else{
              return new Container();
            }

        }
    );
  }
  }


TextStyle cityStyle(){
  return new TextStyle(color: Colors.white,fontSize: 22.9,fontWeight: FontWeight.w500);
}

TextStyle tempStyle(){
  return new TextStyle(color: Colors.white,fontSize: 45.9,fontWeight: FontWeight.w600);
}