import 'dart:ffi';

void main(List<String> arguments) {
  //  String buffer
  // Better performance
  final message = StringBuffer();
  message.write('My Name Is');
  message.write(' João');
  print(message.toString());

  // Morning task
  const double average = 8.5;
  List<double> grades = [8.2, 8.5, 9.8, 9.9, 9, 7.8, 6.5];
  List<double> highGrades =
      grades.where((element) => element >= average).toList();

  print(highGrades.runtimeType);
  print(highGrades);
  print(grades);
}
