import 'package:demoapp/cubit/cubit/ph_login_cubit.dart';
import 'package:demoapp/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<PhLoginCubit>(context).logout();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(Icons.power_off))
        ],
        title: Text('Home'),
      ),
      body: Center(
        child: Container(
          child: Text('Logged In'),
        ),
      ),
    );
  }
}
