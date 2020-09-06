import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

String equation = '0';
String result = '0';
String expression = '';
double equationFS = 38.0;
double resultFS = 48.0;

class _SimpleCalculatorState extends State<SimpleCalculator> {

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == 'CLR'){
        equation = '0';
        result = '0';
        equationFS = 38.0;
        resultFS = 48.0;
      }
      else if(buttonText == '⌫'){
        equationFS = 48.0;
        resultFS = 38.0;
        equation = equation.substring(0,equation.length-1);
        if(equation == ''){
          equation = '0';
        }
      }
      else if(buttonText == '='){
        equationFS = 38.0;
        resultFS = 48.0;
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Error';
        }
      }
      else{
        if(equation == '0'){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Colors.black54,width: 1,style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Calculator'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFS),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultFS),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('CLR', 1, Colors.redAccent),
                        buildButton('⌫', 1, Colors.blueAccent),
                        buildButton('÷', 1, Colors.blueAccent),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton('7', 1, Colors.black54),
                          buildButton('8', 1, Colors.black54),
                          buildButton('9', 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('4', 1, Colors.black54),
                          buildButton('5', 1, Colors.black54),
                          buildButton('6', 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('3', 1, Colors.black54),
                          buildButton('2', 1, Colors.black54),
                          buildButton('1', 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('.', 1, Colors.black54),
                          buildButton('0', 1, Colors.black54),
                          buildButton('00', 1, Colors.black54),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('×', 1, Colors.blueAccent),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton('-', 1, Colors.blueAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('+', 1, Colors.blueAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('=', 2, Colors.redAccent),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
