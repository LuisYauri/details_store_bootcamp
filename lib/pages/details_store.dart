import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DetailsStore extends StatefulWidget {
  @override
  _DetailsStoreState createState() => _DetailsStoreState();
}

class _DetailsStoreState extends State<DetailsStore> {
  List itemDetailsList = [
    {
      'title': 'Desing File',
      'subTitle': '38.66 GB',
      'store': 20,
      'color': Color(0xFF22215B),
    },
    {
      'title': 'Images',
      'subTitle': '24.80 GB',
      'store': 80,
      'color': Color(0xFFFFC700),
    },
    {
      'title': 'Video',
      'subTitle': '12.60 GB',
      'store': 90,
      'color': Color(0xFF4CE364),
    },
    {
      'title': 'Documents',
      'subTitle': '06.57 GB',
      'store': 85,
      'color': Color(0xFF567DF4),
    },
    {
      'title': 'Others',
      'subTitle': '2.01 GB',
      'store': 50,
      'color': Color(0xFFFF842A),
    }
  ];

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              appBarWidget(),
              chartWidget(),
              SizedBox(
                height: 10,
              ),
              detailsWidget(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarWidget() {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Image.asset('assets/img/arrow_left.png'),
            onPressed: () {},
          ),
          Text(
            'Storage Details',
            style: TextStyle(
              color: Color(0xFF22215B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          IconButton(
            icon: Image.asset('assets/img/more_option.png'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget chartWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          charPieWidget(),
          Text(
            'Available',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF22215B),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '43.36 GB',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF22215B),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Total 128 GB',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF22215B),
            ),
          ),
        ],
      ),
    );
  }

  Widget charPieWidget() {
    return Container(
      child: pieChartComponent(),
    );
  }

  Widget pieChartComponent() {
    return AspectRatio(
      aspectRatio: 1.9,
      child: Container(
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff567DF4),
            value: 40,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff22215B),
            value: 30,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffFFC700),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  Widget detailsWidget() {
    return Container(
      child: Expanded(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  for (var item in itemDetailsList)
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: itemDetailsWidget(item),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            exportWidget(),
          ],
        ),
      ),
    );
  }

  Widget itemDetailsWidget(item) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  right: 10,
                ),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item['color'],
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${item['title']}',
                    style: TextStyle(
                      color: Color(0xFF22215B),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text('${item['subTitle']}'),
                ],
              ),
            ],
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  width: 130,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF7FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: getTransformWidth(item['store']),
                    height: 5,
                    decoration: BoxDecoration(
                      color: item['color'],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double getTransformWidth(value) {
    return (130 * value) / 100;
  }

  Widget exportWidget() {
    return Container(
      height: 40,
      child: Center(
        child: FlatButton(
          child: Text(
            'Export Details',
            style: TextStyle(
              color: Color(0xFF22215B),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            print('Click');
          },
        ),
      ),
    );
  }
}
