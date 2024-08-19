import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<String> findEmployeeById(String payrollId) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // Obtener instancia de SharedPreferences
    
      // Leer datos almacenados en SharedPreferences
      final sharedEmployee = prefs.getString('employee') ?? '';

      if (sharedEmployee.isNotEmpty) {
        // Decodificar JSON almacenado
        return sharedEmployee;
      }

      // Si no hay datos almacenados o el ID no coincide, realizar una solicitud HTTP
      final url = Uri.parse('https://arle.orgfree.com/gaffet/gaffet.php?resource=employee&payroll_id=$payrollId');
      final response = await http.get(url);
      

      if (response.statusCode == 200) {
        // Suponiendo que la respuesta sea un JSON
        final json = response.body;

        // Almacenar la respuesta JSON completa como un string
        await prefs.setString('employee', json);

        //También hacemos una modificación en la base de datos y decimos que el usuario ya se logueo
        final url2 = Uri.parse('https://arle.orgfree.com/gaffet/gaffet.php?resource=setLogin&payroll_id=$payrollId');
        final response2 = await http.get(url2);
        if (kDebugMode) {
          print(response2.body);
        }

        return json;  // Retornar el JSON completo
      } else {
        return "error";  // Retornar error si la solicitud no es exitosa
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en el login: $e');
      }
      return e.toString();
    }
  }
}
