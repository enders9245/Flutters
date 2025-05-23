import 'package:calc_upeux/comp/CustomAppBarX.dart';
import 'package:calc_upeux/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import './comp/CalcButton.dart';

void main() => runApp(const CalcApp());

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  String valorAnt = '';
  String operador = '';
  TextEditingController _controller = TextEditingController();

  void numClick(String text) {
    setState(() {
      // Evitar que se escriba más de un punto decimal
      if (text == '.' && _controller.text.contains('.')) return;
      _controller.text += text;
    });
  }

  void clear(String text) {
    setState(() {
      _controller.text = '';
      valorAnt = '';
      operador = '';
    });
  }

  void opeClick(String text) {
    setState(() {
      if (_controller.text.isNotEmpty) {
        if (valorAnt.isNotEmpty && operador.isNotEmpty) {
          // Hacer cálculo con el operador anterior
          try {
            double num1 = double.parse(valorAnt);
            double num2 = double.parse(_controller.text);
            double res = 0;

            switch (operador) {
              case "/":
                if (num2 == 0) {
                  _controller.text = 'Error: Div 0';
                  return;
                }
                res = num1 / num2;
                break;
              case "*":
                res = num1 * num2;
                break;
              case "+":
                res = num1 + num2;
                break;
              case "-":
                res = num1 - num2;
                break;
              case "%":
                res = num1 % num2;
                break;
            }

            valorAnt = res.toString();
            _controller.text = '';
          } catch (e) {
            _controller.text = 'Error';
            return;
          }
        } else {
          valorAnt = _controller.text;
          _controller.text = '';
        }
        operador = text;
      } else if (valorAnt.isNotEmpty) {
        // Permitir cambiar operador sin borrar valor previo
        operador = text;
      }
    });
  }

  void resultOperacion(String text) {
    setState(() {
      if (valorAnt.isEmpty || operador.isEmpty || _controller.text.isEmpty) {
        return; // No hay operación completa
      }
      try {
        double num1 = double.parse(valorAnt);
        double num2 = double.parse(_controller.text);
        double res = 0;

        switch (operador) {
          case "/":
            if (num2 == 0) {
              _controller.text = 'Error: Div 0';
              return;
            }
            res = num1 / num2;
            break;
          case "*":
            res = num1 * num2;
            break;
          case "+":
            res = num1 + num2;
            break;
          case "-":
            res = num1 - num2;
            break;
          case "%":
            res = num1 % num2;
            break;
        }

        _controller.text = res.toString();
        valorAnt = '';
        operador = '';
      } catch (e) {
        _controller.text = 'Error';
      }
    });
  }

  void accion() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> labelList = [
      ["AC", "C", "%", "/"],
      ["7", "8", "9", "*"],
      ["4", "5", "6", "-"],
      ["1", "2", "3", "+"],
      [".", "0", "00", "="]
    ];

    List<List<Function(String)>> funx = [
      [clear, clear, opeClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, resultOperacion],
    ];

    AppTheme.colorX = Colors.blue;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: CustomAppBar(accionx: accion),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                  readOnly: true,
                  style: const TextStyle(fontSize: 32),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(labelList.length, (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(labelList[index].length, (indexx) {
                    String text = labelList[index][indexx];
                    return CalcButton(
                      text: text,
                      callback: funx[index][indexx],
                    );
                  }),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
