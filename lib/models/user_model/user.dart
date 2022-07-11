import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.password});

  final String id;
  final String password;

  @override
  List<Object> get props => [id, password];

  static const empty = User(id: '-', password: '-');
}
