class FormValidator {

 static String? validation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Text field can not be empty!';
    }
    return null;
  }
  
}



