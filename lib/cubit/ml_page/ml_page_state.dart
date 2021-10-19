part of 'ml_page_cubit.dart';

@immutable
abstract class MlPageState {}

class MlPageInitial extends MlPageState {} //Image not picked Yet

class ImageLoad extends MlPageState {}

class PictureLoaded extends MlPageState {
  File file;
  PictureLoaded({
    required this.file,
  });
}

class DoML extends MlPageState {
  File file;
  DoML({
    required this.file,
  });
}

class MlDOne extends MlPageState {
  bool isFace;
  MlDOne({
    required this.isFace,
  });

  
}
