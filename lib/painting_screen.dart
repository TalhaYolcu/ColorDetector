import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:floodfill_image/floodfill_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:http/http.dart' as http;
import 'line_chart_sample10.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';

class PaintingScreen extends StatefulWidget {
  late String file;
  late BluetoothDevice server;
  late String modal = 'Modal 1';
  late String epoch = '500';
  PaintingScreen(
      {required this.file,
      required this.server,
      required this.modal,
      required this.epoch});

  @override
  State<PaintingScreen> createState() =>
      _PaintingScreenState(file, server, modal, epoch);
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _PaintingScreenState extends State<PaintingScreen> {
  Color _fillColor = Colors.white;
  Color specific_color = Colors.white;
  late String file_inner;
  late final BluetoothDevice server;
  late String modal = 'Modal 1';
  late String epoch = '500';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool think_enabled = false;
  bool waiting_for_response = false;
  bool paintable = false;
  bool visible_double_values = false;
  //"modals/modal_1_50.modal"
  String modal_string = "modals/modal_";
  String default_modal = "1";
  String underscore = "_";
  String epoch_string = "50";
  String dot_modal = ".modal";
  List<String> thoughts = List<String>.empty(growable: true);

  List<int> array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  _PaintingScreenState(
      String file, BluetoothDevice server, String modal, String epoch) {
    file_inner = file;
    this.server = server;
    this.modal = modal;
    this.epoch = epoch;
  }

  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  double red_value = 0.0;
  double green_value = 0.0;
  double blue_value = 0.0;
  double red_value_print = 0.0;
  double green_value_print = 0.0;
  double blue_value_print = 0.0;
  bool show_graph = false;

  //1.yi sil, 1-14 e gönder
  //boyamadan önce rengi yazdır, 3 değeri yazdır
  late List<List<int>> array_of_array = List<List<int>>.empty(growable: true);
  late List<List<int>> graph_array_of_array =
      List<List<int>>.empty(growable: true);
  int graph_array_of_array_size_counter = 0;
  List<String> income_results = ['26.99', '27.33', '45,68'];
  List<double> income_results_double = [100.0, 0.0, 0.0];
  String secret_key =
      "LEE8_Vqi7xNXue1QR2n4ibXXMjnfSRs8E5Juil7AccgQAzFuSSzOkg=="; //Muhammed den alıcaz
  final Color sinColor = Colors.redAccent;
  final Color cosColor = Colors.blueAccent;

  final limitCount = 20;
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

  int xValue = 0;
  int step = 1;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    determine_modal_and_epoch();
    thoughts.clear();
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        sinPoints.add(FlSpot(xValue.toDouble(), math.sin(xValue)));
        cosPoints.add(FlSpot(xValue.toDouble(), math.cos(xValue)));

        if (limitCount < graph_array_of_array_size_counter) {
          i0p.remove(0);
          i1p.remove(0);
          i2p.remove(0);
          i3p.remove(0);
          i4p.remove(0);
          i5p.remove(0);
          i6p.remove(0);
          i7p.remove(0);
          i8p.remove(0);
          i9p.remove(0);
          i10p.remove(0);
          i11p.remove(0);
          i12p.remove(0);
          i13p.remove(0);
        }

        if (graph_array_of_array_size_counter < graph_array_of_array.length) {
          while (graph_array_of_array_size_counter !=
              graph_array_of_array.length) {
            i0p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][0]
                    .toDouble()));
            i1p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][1]
                    .toDouble()));
            i2p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][2]
                    .toDouble()));
            i3p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][3]
                    .toDouble()));
            i4p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][4]
                    .toDouble()));
            i5p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][5]
                    .toDouble()));
            i6p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][6]
                    .toDouble()));
            i7p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][7]
                    .toDouble()));
            i8p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][8]
                    .toDouble()));
            i9p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][9]
                    .toDouble()));
            i10p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][10]
                    .toDouble()));
            i11p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][11]
                    .toDouble()));
            i12p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][12]
                    .toDouble()));
            i13p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][13]
                    .toDouble()));
            /*
            i14p.add(FlSpot(
                graph_array_of_array_size_counter.toDouble(),
                graph_array_of_array[graph_array_of_array_size_counter][14]
                    .toDouble()));
                    */
            graph_array_of_array_size_counter++;
          }
        }
      });
      xValue += step;
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("PAINTING"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      show_graph = !show_graph;
                    });
                  },
                  child: Text('Show/Hide Graph')),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: show_graph,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 100,
                          minX: graph_array_of_array_size_counter - 100,
                          maxX: graph_array_of_array_size_counter + 1,
                          lineTouchData: LineTouchData(enabled: false),
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
                            //drawLine(i14p, Colors.yellow),
                          ],
                          titlesData: FlTitlesData(
                            show: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FloodFillImage(
                imageProvider: AssetImage(file_inner),
                fillColor: _fillColor,
                avoidColor: [Colors.transparent, Colors.black],
                tolerance: 10,
                width: 350,
                height: 350,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: !think_enabled,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            think_enabled = true;
                            paintable = false;
                            visible_double_values = false;
                          });
                        },
                        child: Text(
                          'Start to think',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: think_enabled && !paintable,
                child: TextButton(
                  child: Text(
                    'End thinking',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey)),
                  onPressed: () async {
                    setState(() {
                      waiting_for_response = true;
                    });
                    String temp_income = await trial_post();
                    setState(() {
                      waiting_for_response = false;
                      visible_double_values = true;
                    });
                    print(temp_income);

                    temp_income =
                        temp_income.substring(1, temp_income.length - 1);
                    //print(temp_income);
                    income_results = temp_income.split(', ');
                    for (int i = 0; i < income_results.length; i++) {
                      income_results_double[i] =
                          double.parse(income_results[i]);
                    }
                    setState(() {
                      red_value_print = income_results_double[0];
                      green_value_print = income_results_double[1];
                      blue_value_print = income_results_double[2];
                      red_value = income_results_double[0] * 25.5;
                      green_value = income_results_double[1] * 25.5;
                      blue_value = income_results_double[2] * 25.5;

                      double m1 = return_max(
                          income_results_double[0], income_results_double[1]);
                      double m2 = return_max(
                          income_results_double[1], income_results_double[2]);
                      double m3 = return_max(m1, m2);

                      if (income_results_double[0] == m3) {
                        _fillColor = Color.fromARGB(255, 255, 0, 0);
                      } else if (income_results_double[1] == m3) {
                        _fillColor = Color.fromARGB(255, 0, 255, 0);
                      } else if (income_results_double[2] == m3) {
                        _fillColor = Color.fromARGB(255, 0, 0, 255);
                      }
                      specific_color = Color.fromARGB(255, red_value.toInt(),
                          green_value.toInt(), blue_value.toInt());
                    });
                    print("After first set state");
                    //Navigator.pop(context);
                    print("After pop");
                    setState(() {
                      paintable = true;
                      think_enabled = false;
                    });
                    print("After second set state");
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: paintable,
                child: Text(
                  'Tap an area to paint',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: waiting_for_response,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Waiting for response'),
                        SizedBox(
                          height: 15,
                        ),
                        LinearProgressIndicator(
                            backgroundColor: Colors.black,
                            valueColor: AlwaysStoppedAnimation(Colors.red)),
                      ],
                    )),
              ),
              Visibility(
                visible: visible_double_values,
                child: Column(children: [
                  Text(
                    'Red value:$red_value_print',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Green value:$green_value_print',
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Blue value:$blue_value_print',
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Color to be painted: main color:',
                    style: TextStyle(color: _fillColor),
                  ),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: _fillColor),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Color to be painted: specific color:',
                    style: TextStyle(color: specific_color),
                  ),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: specific_color),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
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

  Future<String> trial_post() async {
    //"modal": "modals/modal_1_50.modal"
    //1:modal numarası
    //50:epoch değeri
    //print(array_of_array);

    for (int i = 0; i < thoughts.length; i++) {
      var arr = thoughts[i].split('-');
      for (int k = 1; k < 15; k++) {
        array[k - 1] = int.parse(arr[k]);
      }
      array_of_array.add(array);
    }
    thoughts.clear();
    print(array_of_array);
    var body = jsonEncode({"data": array_of_array, "modal": modal_string});
    var response = await http.post(
        Uri.parse(
            'https://ikbal-tech-func-color-classifier.azurewebsites.net/api/color-checker'),
        body: body,
        headers: {"x-functions-key": secret_key});
    //print(response.body);
    array_of_array.clear();

    return response.body.toString();
  }

  void determine_modal_and_epoch() {
    if (modal == 'Modal 1') {
      default_modal = "1";
    } else if (modal == 'Modal 2') {
      default_modal = "2";
    } else if (modal == 'Modal 3') {
      default_modal = "3";
    } else if (modal == 'Modal 4') {
      default_modal = "4";
    } else if (modal == 'Modal 5') {
      default_modal = "5";
    } else if (modal == 'Modal 6') {
      default_modal = "6";
    } else if (modal == 'Modal 7') {
      default_modal = "7";
    } else if (modal == 'Modal 8') {
      default_modal = "8";
    } else if (modal == 'Modal 9') {
      default_modal = "9";
    } else if (modal == 'Modal 10') {
      default_modal = "10";
    } else if (modal == 'Modal 11') {
      default_modal = "11";
    } else if (modal == 'Modal 12') {
      default_modal = "12";
    } else if (modal == 'Modal 13') {
      default_modal = "13";
    } else if (modal == 'Modal 14') {
      default_modal = "14";
    } else if (modal == 'Modal 15') {
      default_modal = "15";
    }
    epoch_string = epoch;
    modal_string += default_modal;
    modal_string += underscore;
    modal_string += epoch_string;
    modal_string += dot_modal;
    print(modal_string);
  }

  void send_data_to_firebase() {
    CollectionReference firstryref = firestore.collection('FIRST_TRY');
    List values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

    firstryref.add({
      'N1': 1,
      'N2': 2,
      'N3': 3,
      'N4': 4,
      'N5': 5,
      'N6': 6,
      'N7': 7,
      'N8': 8,
      'N9': 9,
      'N10': 10,
      'N11': 11,
      'N12': 12,
      'N13': 13,
      'N14': 14,
      'N15': 15,
    });
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    setState(() {
      String data_text = messages.last.text;
      if (think_enabled) {
        thoughts.add(data_text);
      }
      add_to_graph_array(data_text);
    });
  }

  double return_max(
      double income_results_double, double income_results_double2) {
    if (income_results_double > income_results_double2) {
      return income_results_double;
    }
    return income_results_double2;
  }

  void add_to_graph_array(String data_text) {
    var arr = data_text.split('-');
    for (int k = 0; k < 14; k++) {
      array[k] = int.parse(arr[k]);
    }
    graph_array_of_array.add(array);
  }
}
