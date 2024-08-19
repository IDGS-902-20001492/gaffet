import 'package:flutter/material.dart';
import 'package:gaffet/models/employee.dart';
import 'package:gaffet/widgets/qr_code_widget.dart';

class Page2 extends StatefulWidget {
  final Employee employee;

  Page2({required this.employee});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          width: 350,
          height: 610,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 199, 222, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 6, 36, 61).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 30,
                right: 30,
                child: Text(
                  "Código QR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                bottom: 300,
                left: 0,
                right: 0,
                child: Center(
                  child: generateQrCode(widget.employee.Nombre+","+widget.employee.No_Empleado),
                ),
              ),
              Positioned(
                top: 320,
                left: 30,
                right: 30,
                child: Text(
                  "Términos y Condiciones",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 360,
                left: 30,
                right: 30,
                child: Text(
                  "Esta credencial es intransferible y el uso indebido de esta aplicará medidas disciplinarias.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 430,
                left: 30,
                right: 30,
                child: Text(
                  "Esta credencial digital no sustituye a la física, por lo que solo puede ser usada para el sistema de comedor.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.employee.Tipo == '1' ? 'Nómina Catorcenal' : 'Nómina Semanal',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
