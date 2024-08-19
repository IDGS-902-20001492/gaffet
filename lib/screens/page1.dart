import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaffet/models/employee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page1 extends StatefulWidget {
  final Employee employee;

  Page1({required this.employee});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final ImagePicker _picker = ImagePicker();
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> _openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        File imageFile = File(image.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        _prefs?.setString('image', base64Image);

        // Actualiza la UI después de guardar la imagen
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error al abrir la cámara: $e');
    }
  }

  void _selectPhoto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Seleccionar foto"),
          content: Text("¿De dónde quieres seleccionar la foto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo antes de abrir la cámara
                _openCamera();
              },
              child: Text("Cámara"),
            ),
          ],
        );
      },
    );
  }

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
              colors: [Colors.blue, Colors.white],
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
                top: 10,
                left: 30,
                right: 30,
                child: Text(
                  "XSdM",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 30,
                right: 30,
                child: Text(
                  "Credencial de Empleado",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 70,
                right: 70,
                child: _prefs?.getString('image') != null &&
                        _prefs!.getString('image')!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          base64Decode(_prefs!.getString('image')!),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ImageIcon(
                        AssetImage('assets/user_icon.png'),
                        size: 200,
                    ),
                ),
                Positioned(
                top: 305,
                left: 145,
                right: 145,
                child: _prefs?.getString('image') == null || _prefs!.getString('image')!.isEmpty
                        ? ElevatedButton(
                            onPressed: _selectPhoto,
                            child: Icon(Icons.camera_alt),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          )
                        : Text(''),
              ),
              Positioned(
                top: 370,
                left: 30,
                right: 30,
                child: Text(
                  widget.employee.Nombre,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 450,
                left: 30,
                right: 30,
                child: Text(
                  "Dado de alta en sistema el: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 68, 68, 68),
                  ),
                ),
              ),
              Positioned(
                top: 470,
                left: 30,
                right: 30,
                child: Text(
                  "${widget.employee.FechaAlta}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.employee.No_Empleado,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Botón para abrir la cámara
            ],
          ),
        ),
      ),
    );
  }
}
