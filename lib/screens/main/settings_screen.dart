import 'package:app_marketing_version_2/helpers/validation.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/pick_image.dart';
import 'package:app_marketing_version_2/widgets/button_custom.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';
import 'package:app_marketing_version_2/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AspectRatio(
            aspectRatio: _aspectRatio * 2.5,
            child: Container(
                width: double.infinity,
                color: Colors.red[800],
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        context.watch<PickImage>().pathImage != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.redAccent,
                                backgroundImage: FileImage(
                                    context.watch<PickImage>().pathImage!),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.redAccent,
                                backgroundImage:
                                    AssetImage('assets/images/icon_person.png'),
                              ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        Text(
                          '${context.read<Authenicator>().firebaseAuth.currentUser!.displayName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: _height * 0.12,
                        right: _width * 0.3,
                        child: MaterialButton(
                          onPressed: () => print('1'),
                          height: _height * 0.07,
                          minWidth: _width * 0.1,
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide.none),
                          child: Icon(
                            Icons.add_a_photo,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                    Positioned(
                      bottom: _height * 0.045,
                      right: _width * 0.1,
                      child: IconButton(
                        onPressed: () => editText(context),
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Text(
            context
                .read<Authenicator>()
                .firebaseAuth
                .currentUser!
                .email
                .toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      )),
    );
  }

  editText(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldCustom(
              chooseStyle: false,
              textAlign: TextAlign.center,
              onChanged: Validation.saveName,
              hintText: context
                  .read<Authenicator>()
                  .firebaseAuth
                  .currentUser!
                  .displayName
                  .toString(),
            ),
            ButtonCustom(
              onPressed: () async {
                LoadingSpinkit.loadingSpinkit(context);
                await context
                    .read<Authenicator>()
                    .firebaseAuth
                    .currentUser!
                    .updateProfile(displayName: Validation.name!.trim());
                Navigator.of(context).pop();
                return Navigator.of(context).pop();
              },
              color: Colors.green,
              height: 35,
              radius: 30,
              sideColor: Colors.green,
              textButton: 'Ok',
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
