import 'dart:io';

import 'package:demoapp/cubit/login/ph_login_cubit.dart';
import 'package:demoapp/cubit/ml_page/ml_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class MLApp extends StatefulWidget {
  @override
  State<MLApp> createState() => _MLAppState();
}

class _MLAppState extends State<MLApp> {
  final ImagePicker _picker = ImagePicker();
  final faceDetector = GoogleMlKit.vision.faceDetector();

  @override
  void dispose() {
    faceDetector.close();

    super.dispose();
  }

  Future<bool> doml(File file) async {
    final inputImage = InputImage.fromFile(file);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    if (faces.length > 0)
      return true;
    else
      return false;
  }

  Future<File?> pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      File imgtemporary = File(image.path);
      return imgtemporary;
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image Permission")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ML Page'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: BlocListener<MlPageCubit, MlPageState>(
            listener: (context, state) async {
              if (state is DoML) {
                bool face = await doml(state.file);
                context.read<MlPageCubit>().mldone(face);
              }
            },
            child: BlocBuilder<MlPageCubit, MlPageState>(
              builder: (context, state) {
                if (state is MlPageInitial) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Upload an Image"),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            File? file = await pickimage();
                            if (file != null) {
                              context.read<MlPageCubit>().ImageLoaded(file);
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Icon(Icons.photo),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is PictureLoaded) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.file(
                            state.file,
                            height: 350,
                            width: 300,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<MlPageCubit>().DOML(state.file);
                            },
                            child: Text("Do ML"))
                      ],
                    ),
                  );
                } else if (state is DoML) {
                  return Container(
                    child: Text("Loading"),
                  );
                } else if (state is MlDOne) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Face ::: " + state.isFace.toString()),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<MlPageCubit>().reload();
                            },
                            child: Text("Re Load")),
                      ],
                    ),
                  );
                } else
                  return Container();
              },
            ),
          ),
        ));
  }
}
