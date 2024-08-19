class Employee {
  String Id_Empleado;
  String Nombre;
  String No_Empleado;
  String FechaAlta;
  String FechaBaja;
  String Token;
  String Tipo;
  String mobileLoged;

  Employee({required this.Id_Empleado, required this.Nombre, required this.No_Empleado, required this.FechaAlta, required this.FechaBaja, required this.Token, required this.Tipo, required this.mobileLoged});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      Id_Empleado: json['Id_Empleado'],
      Nombre: json['Nombre'],
      No_Empleado: json['No_Empleado'],
      FechaAlta: json['FechaAlta'],
      FechaBaja: json['FechaBaja'] ?? '',
      Token: json['Token'] ?? '',
      Tipo: json['Tipo'] ?? '',
      mobileLoged: json['mobileLoged'] ?? 'false',
    );
  }
}