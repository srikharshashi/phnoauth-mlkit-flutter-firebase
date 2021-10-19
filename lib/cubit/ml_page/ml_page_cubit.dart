import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ml_page_state.dart';

class MlPageCubit extends Cubit<MlPageState> {
  MlPageCubit() : super(MlPageInitial());

  void ImageLoaded(File file) {
    emit(PictureLoaded(file: file));
  }

  void DOML(File file) {
    emit(DoML(file: file));
  }

  void mldone(bool isface) {
    emit(MlDOne(isFace: isface));
  }

  void reload() {
    emit(MlPageInitial());
  }
}
