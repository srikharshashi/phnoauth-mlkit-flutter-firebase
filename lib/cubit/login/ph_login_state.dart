part of 'ph_login_cubit.dart';

@immutable
abstract class PhLoginState {}

class PhLoginInitial extends PhLoginState {}

class GetOTP extends PhLoginState{}

class LoginLoad extends PhLoginState{}

class loggedin extends PhLoginState{}

class LoginError extends PhLoginState{}
