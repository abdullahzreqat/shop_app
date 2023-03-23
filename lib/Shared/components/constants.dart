bool checkValid(value){
  return RegExp(r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(value);
}
void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String? token;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}