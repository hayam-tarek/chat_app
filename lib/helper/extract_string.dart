String extractName({required String email}) {
  int i = 0;
  String finalName = '';
  while (email[i] != '@') {
    finalName += email[i];
    i++;
  }
  return finalName;
}
