import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<String> buttons = [
    'Del',
    'C',
    '( )',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];

  String data = "0";
  String result = "";
  String history = "";
  double resultSize = 20;
  double dataSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildDisplays(result, resultSize),
                    buildDisplays(data, dataSize),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 491,
                alignment: Alignment.bottomRight,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: buttons.map((e) {
                    switch (e) {
                      case "÷":
                      case "×":
                      case "+":
                      case "-":
                        return buildButtons(e: e, btnColor: Colors.orangeAccent, txtColor: Colors.black, onTaped: (){
                          setState(() {
                            data += e;
                          });
                        });
                      case "Del":
                        return buildButtons(
                            e: e,
                            btnColor: Colors.grey,
                            txtColor: Colors.deepOrange,
                            onTaped: () {
                              setState(() {
                                data == "Math Error" || data == "Infinity"? data = '0': "";
                                if (data.length > 1) {
                                  data = data.substring(0, data.length - 1);
                                } else {
                                  data = '0';
                                }
                              });
                            });
                      case "C":
                        return buildButtons(
                            e: e,
                            btnColor: Colors.grey,
                            txtColor: Colors.black,
                            onTaped: () {
                              setState(() {
                                data = "0";
                                result = "";
                                history = "";
                              });
                            });
                      case "( )":
                        return buildButtons(
                            e: e,
                            btnColor: Colors.grey,
                            txtColor: Colors.black,
                            onTaped: () {
                              setState(() {
                                if (data[data.length - 1] == '-' ||
                                    data[data.length - 1] == '+' ||
                                    data[data.length - 1] == '×' ||
                                    data[data.length - 1] == '÷' ||
                                    data == '0' && !data.contains('(')) {
                                  if (data == '0') {
                                    data = "";
                                  }
                                  data += '(';
                                } else if (data.contains('(')) {
                                  data += ')';
                                }
                              });
                            });
                      case "=":
                        return buildButtons(e: e, btnColor: Colors.orangeAccent, txtColor: Colors.black, onTaped: (){
                          setState(() {
                            dataSize = 40;
                            resultSize = 25;
                            result = data;
                            history = result;
                            var data2 = data.replaceAll("×", "*");
                            data2 = data2.replaceAll("÷", "/");
                            try {
                              var p = Parser();
                              Expression exp = p.parse(data2);
                              data2 = exp
                                  .evaluate(
                                  EvaluationType.REAL, ContextModel())
                                  .toString();
                              var text = data2.split('.');
                              if (data2.contains('.')) {
                                text[1] == '0' ? data = text[0] : data = data2;
                              }else{
                                data = data2;
                              }
                            } catch (error) {
                              data = "Math Error";
                              result = "";
                              history ="";
                            }

                          });
                        });
                    }
                    return buildButtons(
                      btnColor: Colors.grey[900]!,
                      e: e,
                      txtColor: Colors.white,
                      onTaped: () {
                        setState(() {
                          if (data == "0" && data.length <= 1) {
                            data = "";
                          }
                          data += e;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDisplays(String txt, double size) {
    return Container(
      height: 120,
      width: double.infinity,
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(10),
      child: Text(
        txt,
        style: TextStyle(fontSize: size, color: Colors.white),
        maxLines: 2,
        textAlign: TextAlign.end,
        overflow: TextOverflow.clip,
      ),
    );
  }

  Container buildButtons(
      {required String e,
      required Color btnColor,
      required Color txtColor,
      required void Function() onTaped}) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: btnColor
        ),
        onPressed: onTaped,
        child: e == "Del"
            ? const Icon(
                Icons.backspace_outlined,
                color: Colors.black,
              )
            : Text(
                e,
                style: TextStyle(color: txtColor, fontSize: 25),
              ),
      ),
    );
  }
}
