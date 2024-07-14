import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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

  var background = Color(0xFFFCCB7F);   // 배경색상을 저장할 변수 요즘 날씨가 더워서 기본 색상으로 더운 색상으로 지정
  var textground = Color(0xFFFCCB7F);   // 상세 정보 컬러
  String image = "images/hotImg.png";

  DateFormat format = DateFormat('H시 m분 s초');
  DateFormat sun = DateFormat('H시 m분');

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

    /*
    구성된 getData 함수에 배경 색을 변경하는 코드 추가
    21도 이하면 서늘한 색상 or 22도 이상이면 따스한 색상
     */
    if(weatherData['main']['temp'] < 21) {
      background = Color(0xFF53ABCC);
      textground = Color(0xFF53ABCC);
      image = "images/coldImg.png";
      print('So Cold!!');
    } else {
      background = Color(0xFFFCCB7F);
      textground = Color(0xFFFCCB7F);
      image = "images/hotImg.png";
      print('So Hottt!!');
    }
    return weatherData;
  }

  /*
  메인 페이지 구성을 위한 함수 생성
  _onRefresh 함수 호출 시 setState 동작
   */
  Future<Null> _onRefresh()async {
    setState(() {

    });
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
      // 메인 페이지 옆에 사이드 탭
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
                    ),
                  ),
                  Divider(color: Colors.black,),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                  )
                ],
              ),
            )
          ],
        ),
      ),

      /*
      새로고침시 동작할 함수 _onRefresh 등록
      화면을 아래로 스크롤 시 새로고침
       */
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        /*
                    ScaffoldState가 null일 수 있기 때문에 조건부 호출을 위해 ?를 붙여 null체크
                     */
                        _scaffoldKey.currentState?.openDrawer();
                      },),
                    Spacer(),
                    Text(
                      'Weather News',
                      style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    Spacer(),

                    gps == true
                        ? IconButton(icon: Icon(Icons.gps_fixed), onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('위치 정보를 정상적으로 받아오고 있습니다.'))
                      );
                    },
                    )
                        : IconButton(icon: Icon(Icons.gps_not_fixed), onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('위치 정보가 정상적이지 않습니다.'))
                      );
                    },
                    )
                  ],
                ),
                
                /*
                FutureBuilder구성 : 새로운 데이터 반환시 새로고침
                미래에 데이터가 올 것이라 예상하고 그 전까지 다른 데이터를 넣어 놓는다.
                 */
                FutureBuilder(
                  future: getData(), 
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(!snapshot.hasData) return CircularProgressIndicator();   // 데이터가 들어와 있지 않다면
                    return Container( // 데이터가 들어왔다면
                      color: background,
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Text('${snapshot.data['weather'][0]['main']}',  // 날씨 정보
                            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 16,),
                              Text('${snapshot.data['name']}',  // 도시 정보
                                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          // 온도 구역
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${snapshot.data['main']['temp'].toStringAsFixed(0)}', // 소수점 표시 안함
                                style: TextStyle(fontSize: 65, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              // Column 형태로 온도 바로 옆에 최고, 최저 온도 작성
                              Column(
                                children: [
                                  Text('°C',
                                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Row(children: [
                                    Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 15,),
                                      Text('${snapshot.data['main']['temp_max'].toStringAsFixed(0)}°C',
                                      style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ],),

                                  Row(children: [
                                    Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 15,),
                                      Text('${snapshot.data['main']['temp_min'].toStringAsFixed(0)}°C',
                                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // API사이트에서 제공하는 아이콘 사용
                          Image.network('http://openweathermap.org/img/wn/' + snapshot.data['weather'][0]['icon'] + '@2x.png'),
                          Image.asset(image, width: MediaQuery.of(context).size.width,), // 화면에 꽉차게

                          // 마지막 업데이트 시간 표시
                          Container(
                            padding: EdgeInsets.only(right: 10, top: 10),
                            alignment: Alignment.centerRight,
                            child: Text('마지막 업데이트 시간: ${format.format(DateTime.now())}')
                          ),
                          // 세부 정보 레이아웃
                          Container(
                            width: MediaQuery.of(context).size.width-10,
                            child: Card(
                              color: textground,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('More Information!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    SizedBox(height: 10,),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.water_damage, color: Colors.black54,),
                                          Column(
                                            children: [
                                              Text('습도'),
                                              Text('${snapshot.data['main']['humidity'].toStringAsFixed(0)}%')
                                            ],
                                          ),
                                          VerticalDivider(color: Colors.black54,),

                                          Icon(Icons.remove_red_eye, color: Colors.black54,),
                                          Column(
                                            children: [
                                              Text('가시성'),
                                              Text('${snapshot.data['visibility']}')
                                            ],
                                          ),
                                          VerticalDivider(color: Colors.black54,),

                                          Icon(Icons.map_sharp, color: Colors.black54,),
                                          Column(
                                            children: [
                                              Text('국가'),
                                              Text('${snapshot.data['sys']['country']}')
                                            ],
                                          ),
                                          VerticalDivider(color: Colors.black54,)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          infoSpace(Icons.wind_power_sharp, '풍속', '${snapshot.data['wind']['speed']}'),
                                          VerticalDivider(color: Colors.black54,),
                                          infoSpace(Icons.speed, '풍향', '${snapshot.data['wind']['deg']}')
                                        ],
                                      ),
                                    ),
                                    /*
                                     *  API사이트에서 날짜 형태가 아닌 타임스탬프 형태로 데이터를 넘겨줘서 1000을 곱한다
                                     */
                                    SizedBox(height: 20,),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          infoSpace(Icons.wb_sunny, '일출',
                                        sun.format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['sys']['sunrise'] * 1000))),
                                          VerticalDivider(color: Colors.black54,),
                                          infoSpace(Icons.nights_stay, '일몰',
                                        sun.format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['sys']['sunset'] * 1000))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  /*
  마지막 세부 정보 위젯 레이아웃
   */
  Widget infoSpace(IconData icons, String topText, String bottomText) {
    return Container(
      width: MediaQuery.of(context).size.width/2-50,  // 화면 절반만큼  2칸으로 나눠주고 padding값과 margin값만큼 널널하게 50을 뺀다
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icons, color: Colors.black54,),
          Container(
            width: MediaQuery.of(context).size.width/5,
            child: Column(
              children: [
                Text(topText),
                Text(bottomText)
              ],
            )
          )
        ],
      ),
    );
  }
}