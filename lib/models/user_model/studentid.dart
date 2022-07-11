import 'package:formz/formz.dart';

enum StudentIdValidationError { empty }

class StudentId extends FormzInput<String, StudentIdValidationError> {
  const StudentId.pure() : super.pure('');
  const StudentId.dirty([String value = '']) : super.dirty(value);

  @override
  StudentIdValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : StudentIdValidationError.empty;
  }
}
