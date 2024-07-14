import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  드로워 사용을 위한 글로벌 키 생성
  값이 변하지 않기 때문에 final로 선언
   */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool? gps;

  var weatherData;  // API 데이터 변수 선언

  String url = 'http://api.openweathermap.org/data/2.5/weather?'; // API 링크
  String lat = '';                                                // 위도
  String lon = '';                                                // 경도
  String appid = 'appid=9375cf7ab1b655eb49960db7d5ebc132&';       // API 키
  String units = 'units=metric';                                  // 데이터 반환 형태 변수

  void permission() async {
    await Geolocator.requestPermission();
    LocationPermission value = await Geolocator.checkPermission();
    /*
    권한을 체크할 떄마다 GPS값이 변경되면 화면이 업데이트 되도록 함
     */
    setState(() {
      if(value == LocationPermission.always || value == LocationPermission.whileInUse) gps = true;
      else gps = false;
    });
  }
  /*
  날씨 정보를 가져오기 위해 위치 정보 획득
  desiredAccuracy: LocationAccuracy.high 데이터를 가장 높은 정확도로 받아온다

  위치 정보와 정의된 정보들을 조합하여 날씨 정보 획득
  인코딩된 링크 데이터 / 헤더 정보 전달
  받은 데이터를 json형태로 weatherData에 저장한다
   */
  Future getData()async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    lat = "lat=" + position.latitude.toString() + "&";
    lon = "lon=" + position.longitude.toString() + "&";

    http.Response response = await http.get(
      Uri.parse(url + lat + lon + appid + units),
      headers:{"Accept":"application/json"},
    );
    print('Response body: ${response.body}');
    weatherData = jsonDecode(response.body);
    return weatherData;
  }

  /*
  앱을 실행할때 불러오는 함수
  실행할 떄마다 permission함수를 불러와 위치권한 확인
   */
  @override
  void initState() {
    super.initState();
    permission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              // MediaQuery는 디바이스의 크기 값을 불러옴
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // 핸드폰 상태바와 겹치지 않도록 마진 값 추가
              child: Row(
                children: [
                  Text(
                    'Weather App',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera, color: Colors.black,),
                    onPressed: () {
                      print("아무 기능도 없지만 허전해서 그냥 만들어본 버튼");
                    },
                  ),
                  Spacer(), // 화면 반대편에
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.black,),
                    onPressed: () {
                      print("아무 기능도 없지만 그럴싸하게 만들어본 버튼");
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(

                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getData();
        },
      ),
    );
  }
}