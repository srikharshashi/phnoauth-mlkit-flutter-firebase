import 'package:bloc/bloc.dart';
import 'package:demoapp/services/fb_service.dart';
import 'package:meta/meta.dart';

part 'ph_login_state.dart';

class PhLoginCubit extends Cubit<PhLoginState> {
  FirebaseService firebaseService;
  PhLoginCubit({required this.firebaseService}) : super(PhLoginInitial());

  void reset() async {
    //do a firebase logout here first
    emit(PhLoginInitial());
  }

  void login(String phonenumber) async {
    emit(LoginLoad());
    bool pt1 =
        await firebaseService.phoneSignIn(phoneNumber: "+91" + phonenumber);
    if (pt1) {
      emit(GetOTP());
    } else
      emit(LoginError());
  }

  void verifyOTP(String OTP) async {
    emit(LoginLoad());
    bool pt2 = await firebaseService.signinwithOTP(OTP);
    if (pt2) {
      emit(loggedin());
    } else {
      emit(LoginError());
    }
  }

  void logout() async {
    bool pt3 = await firebaseService.signout();
    reset();
  }
}
