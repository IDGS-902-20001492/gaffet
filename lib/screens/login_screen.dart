import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaffet/main.dart';
import 'package:gaffet/models/employee.dart';
import 'package:gaffet/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final Future<String> Function(String) onLogin;

  LoginScreen({required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final payRollIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkStoredEmployee();
  }

  Future<void> _checkStoredEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtener el JSON del empleado almacenado
    final String? storedEmployeeJson = prefs.getString('employee');

    if (storedEmployeeJson != null && storedEmployeeJson.isNotEmpty) {
      // Crear el objeto Employee directamente desde el JSON
      Employee emp = Employee.fromJson(jsonDecode(storedEmployeeJson));

      // Navegar al HomeScreen automáticamente
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(employee: emp),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceso a identificación de empleado', style: TextStyle(color: Colors.white)),
        shadowColor: Colors.grey,
        backgroundColor: Colors.blue[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.0),
                child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número de Nómina asignado por RH',
                ),
                controller: payRollIdController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String payroll = payRollIdController.text;
                String success = await widget.onLogin(payroll);

                if (success != 'error') {
                  try{
                    // No necesitas decodificar el JSON, solo creamos el objeto Employee
                  Employee emp = Employee.fromJson(jsonDecode(success));

                  // Almacenar el empleado en SharedPreferences
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('employee', success);

                  // Navegar al HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(employee: emp),
                    ),
                  );
                  }catch(e){
                    showAlertDialog(context, 'Error', 'Dispostivo sin internet ó sesión activada en otro dispositivo');
                  }
                }else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Inicio de sesión fallido. Por favor, verifica tus credenciales."),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
