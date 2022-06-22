import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LineChartSample10 extends StatefulWidget {
  const LineChartSample10({Key? key}) : super(key: key);

  @override
  _LineChartSample10State createState() => _LineChartSample10State();
}

class _LineChartSample10State extends State<LineChartSample10> {
  final Color sinColor = Colors.redAccent;
  final Color cosColor = Colors.blueAccent;

  final limitCount = 100;
  final sinPoints = <FlSpot>[];
  final cosPoints = <FlSpot>[];
  final i0p = <FlSpot>[];
  final i1p = <FlSpot>[];
  final i2p = <FlSpot>[];
  final i3p = <FlSpot>[];
  final i4p = <FlSpot>[];
  final i5p = <FlSpot>[];
  final i6p = <FlSpot>[];
  final i7p = <FlSpot>[];
  final i8p = <FlSpot>[];
  final i9p = <FlSpot>[];
  final i10p = <FlSpot>[];
  final i11p = <FlSpot>[];
  final i12p = <FlSpot>[];
  final i13p = <FlSpot>[];
  final i14p = <FlSpot>[];

  double xValue = 0;
  double step = 0.05;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      while (i0p.length > limitCount) {
        sinPoints.removeAt(0);
        cosPoints.removeAt(0);
        i0p.removeAt(0);
        i1p.removeAt(0);
        i2p.removeAt(0);
        i3p.removeAt(0);
        i4p.removeAt(0);
        i5p.removeAt(0);
        i6p.removeAt(0);
        i7p.removeAt(0);
        i8p.removeAt(0);
        i9p.removeAt(0);
        i10p.removeAt(0);
        i11p.removeAt(0);
        i12p.removeAt(0);
        i13p.removeAt(0);
        i14p.removeAt(0);

/*
        i0p.removeAt(0);
        i1p.removeAt(0);
        i2p.removeAt(0);
        i3p.removeAt(0);
        i4p.removeAt(0);
        i5p.removeAt(0);
        i6p.removeAt(0);
        i7p.removeAt(0);
        i8p.removeAt(0);
        i9p.removeAt(0);
        i10p.removeAt(0);
        i11p.removeAt(0);
        i12p.removeAt(0);
        i13p.removeAt(0);
        i14p.removeAt(0);  

*/
      }
      setState(() {
        sinPoints.add(FlSpot(xValue, math.sin(xValue)));
        cosPoints.add(FlSpot(xValue, math.cos(xValue)));
        i0p.add(FlSpot(xValue, f_x(0, xValue)));
        i1p.add(FlSpot(xValue, f_x(1, xValue + 1)));
        i2p.add(FlSpot(xValue, f_x(2, xValue + 2)));
        i3p.add(FlSpot(xValue, f_x(3, xValue + 3)));
        i4p.add(FlSpot(xValue, f_x(4, xValue + 4)));
        i5p.add(FlSpot(xValue, f_x(5, xValue + 5)));
        i6p.add(FlSpot(xValue, f_x(6, xValue + 6)));
        i7p.add(FlSpot(xValue, f_x(7, xValue + 7)));
        i8p.add(FlSpot(xValue, f_x(8, xValue + 8)));
        i9p.add(FlSpot(xValue, f_x(9, xValue + 9)));
        i10p.add(FlSpot(xValue, f_x(10, xValue + 10)));
        i11p.add(FlSpot(xValue, f_x(11, xValue + 11)));
        i12p.add(FlSpot(xValue, f_x(12, xValue + 12)));
        i13p.add(FlSpot(xValue, f_x(13, xValue + 13)));
        i14p.add(FlSpot(xValue, f_x(14, xValue + 14)));
/*
        i0p.add(FlSpot(xValue, array_of_array[xValue][0]));
        i1p.add(FlSpot(xValue, array_of_array[xValue][1]));
        i2p.add(FlSpot(xValue, array_of_array[xValue][2]));
        i3p.add(FlSpot(xValue, array_of_array[xValue][3]));
        i4p.add(FlSpot(xValue, array_of_array[xValue][4]));
        i5p.add(FlSpot(xValue, array_of_array[xValue][5]));
        i6p.add(FlSpot(xValue, array_of_array[xValue][6]));
        i7p.add(FlSpot(xValue, array_of_array[xValue][7]));
        i8p.add(FlSpot(xValue, array_of_array[xValue][8]));
        i9p.add(FlSpot(xValue, array_of_array[xValue][9]));
        i10p.add(FlSpot(xValue, array_of_array[xValue][10]));
        i11p.add(FlSpot(xValue, array_of_array[xValue][11]));
        i12p.add(FlSpot(xValue, array_of_array[xValue][12]));
        i13p.add(FlSpot(xValue, array_of_array[xValue][13]));
        i14p.add(FlSpot(xValue, array_of_array[xValue][14]));
*/
        /*
        //array_of_array[xvalue][0-14]6
        
        i0p.add(FlSpot(xValue, f_x(0, xValue)));
        i1p.add(FlSpot(xValue, f_x(1, xValue + 1)));
        i2p.add(FlSpot(xValue, f_x(2, xValue + 2)));
        i3p.add(FlSpot(xValue, f_x(3, xValue + 3)));
        i4p.add(FlSpot(xValue, f_x(4, xValue + 4)));
        i5p.add(FlSpot(xValue, f_x(5, xValue + 5)));
        i6p.add(FlSpot(xValue, f_x(6, xValue + 6)));
        i7p.add(FlSpot(xValue, f_x(7, xValue + 7)));
        i8p.add(FlSpot(xValue, f_x(8, xValue + 8)));
        i9p.add(FlSpot(xValue, f_x(9, xValue + 9)));
        i10p.add(FlSpot(xValue, f_x(10, xValue + 10)));
        i11p.add(FlSpot(xValue, f_x(11, xValue + 11)));
        i12p.add(FlSpot(xValue, f_x(12, xValue + 12)));
        i13p.add(FlSpot(xValue, f_x(13, xValue + 13)));
        i14p.add(FlSpot(xValue, f_x(14, xValue + 14))); 
        */
      });
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return cosPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 300,
                height: 450,
                child: LineChart(
                  LineChartData(
                    minY: 15,
                    maxY: 300,
                    minX: xValue - 1,
                    maxX: xValue,
                    lineTouchData: LineTouchData(enabled: true),
                    clipData: FlClipData.all(),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                    ),
                    lineBarsData: [
                      drawLine(i0p, Colors.red),
                      drawLine(i1p, Colors.green),
                      drawLine(i2p, Colors.amber),
                      drawLine(i3p, Colors.black),
                      drawLine(i4p, Colors.blue),
                      drawLine(i5p, Colors.cyan),
                      drawLine(i6p, Colors.brown),
                      drawLine(i7p, Colors.orange),
                      drawLine(i8p, Colors.grey),
                      drawLine(i9p, Colors.indigo),
                      drawLine(i10p, Colors.purple),
                      drawLine(i11p, Colors.lightBlue),
                      drawLine(i12p, Colors.lime),
                      drawLine(i13p, Colors.tealAccent),
                      drawLine(i14p, Colors.yellow),
                    ],
                    titlesData: FlTitlesData(
                      show: false,
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  LineChartBarData drawLine(List<FlSpot> points, Color color) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
          colors: [color.withOpacity(0), color],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 1.0]),
      barWidth: 4,
      isCurved: false,
    );
  }

  double f_x(double a, double b) {
    return 150 + b;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
