import 'package:demoapp/cubit/login/ph_login_cubit.dart';
import 'package:demoapp/ui/loggedin.dart';
import 'package:demoapp/ui/ml_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Home extends StatefulWidget {
  final TextEditingController numberEditingController = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   numberEditingController = TextEditingController();
  //   widget.otpcontroller = TextEditingController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.grey[900],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  // decoration:
                  // BoxDecoration(border: Border.all(color: Colors.red)),
                  // height: height / 3,
                  // width: width,
                  child: BlocConsumer<PhLoginCubit, PhLoginState>(
                    listener: (context, state) {
                      if (state is loggedin) {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LoggedIN()));
                      }
                    },
                    builder: (context, state) {
                      if (state is PhLoginInitial) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Enter Phone Number",
                                style: TextStyle(color: Colors.black),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: TextField(
                                    controller: widget.numberEditingController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    RegExp regex =
                                        new RegExp(r'^(?:[+0]9)?[0-9]{10}$');
                                    bool valid = regex
                                        .hasMatch(widget.numberEditingController.text);
                                    if (valid) {
                                      print("Ok");
                                      context
                                          .read<PhLoginCubit>()
                                          .login(widget.numberEditingController.text);
                                    } else {
                                      print("Nope");
                                    }
                                  },
                                  child: Text("Submit"))
                            ],
                          ),
                        );
                      } else if (state is GetOTP) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enter OTP",
                              style: TextStyle(color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20),
                              child: PinCodeTextField(
                                useHapticFeedback: true,
                                hapticFeedbackTypes: HapticFeedbackTypes.light,
                                appContext: context,
                                length: 6,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  // print(value);
                                },
                                animationType: AnimationType.fade,
                                enableActiveFill: true,
                                controller: widget.otpcontroller,
                                textStyle: TextStyle(color: Colors.black),
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(10),
                                    activeColor: Colors
                                        .grey, //This is the filled bordere color,
                                    activeFillColor: Colors.grey[600],
                                    selectedColor: Colors.grey[700],
                                    selectedFillColor: Colors.grey[700],
                                    inactiveColor: Colors.grey[600],
                                    inactiveFillColor: Colors.grey[600]),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (widget.otpcontroller.text.length == 6)
                                    context
                                        .read<PhLoginCubit>()
                                        .verifyOTP(widget.otpcontroller.text);
                                  else
                                    print("Nope otp");
                                },
                                child: Text("Verify"))
                          ],
                        );
                      } else if (state is LoginLoad) {
                        return Container(
                          child: Text("Please wait"),
                        );
                      } else if (state is LoginError) {
                        return Container(
                          child: Column(
                            children: [
                              Text(
                                "Login Error",
                              ),
                              Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    context.read<PhLoginCubit>().reset();
                                  },
                                  child: Text("Retry"))
                            ],
                          ),
                        );
                      } else if (state is loggedin) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Logged In"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.read<PhLoginCubit>().logout();
                                },
                                child: Text("LogOut"))
                          ],
                        );
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // decoration:
                  // BoxDecoration(border: Border.all(color: Colors.red)),
                  height: height / 3,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      child: Text("ML FACE"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MLApp()));
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
