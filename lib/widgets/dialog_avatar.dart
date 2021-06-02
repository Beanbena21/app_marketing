import 'package:app_marketing_version_2/helpers/validation.dart';
import 'package:app_marketing_version_2/view_models/authenticator.dart';
import 'package:app_marketing_version_2/view_models/pick_image.dart';
import 'package:app_marketing_version_2/widgets/loading_spinkit.dart';
import 'package:app_marketing_version_2/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'button_custom.dart';
import 'package:provider/provider.dart';

class DialogAvatar {
  static diaglogcustom(BuildContext context, String content) async =>
      await showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) => Dialog(
            child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context
                          .watch<Authenicator>()
                          .firebaseAuth
                          .currentUser!
                          .displayName
                          .toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonCustom(
                      onPressed: () => Navigator.of(context).pop(),
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
            ),
            Positioned(
              top: -50,
              child: context.watch<PickImage>().pathImage != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.redAccent,
                      backgroundImage:
                          FileImage(context.watch<PickImage>().pathImage!),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.redAccent,
                      backgroundImage:
                          AssetImage('assets/images/icon_person.png'),
                    ),
            ),
            Positioned(
              top: 70,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async => await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormFieldCustom(
                            chooseStyle: true,
                            textAlign: TextAlign.center,
                            onChanged: Validation.saveName,
                            hintText: context
                                .read<Authenicator>()
                                .firebaseAuth
                                .currentUser!
                                .displayName
                                .toString(),
                            icon: Icon(Icons.person)),
                        ButtonCustom(
                          onPressed: () async {
                            LoadingSpinkit.loadingSpinkit(context);
                            await context
                                .read<Authenicator>()
                                .firebaseAuth
                                .currentUser!
                                .updateProfile(displayName: Validation.name);
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
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 80,
              child: MaterialButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () async {
                                await context
                                    .read<PickImage>()
                                    .pickImageFromGallery();
                                return Navigator.of(context).pop();
                              },
                              child: Text('Pick Image From Gallery')),
                          TextButton(
                              onPressed: () async {
                                await context
                                    .read<PickImage>()
                                    .pickImageFromCamera();
                                return Navigator.of(context).pop();
                              },
                              child: Text('Pick Image From Camera')),
                        ],
                      ),
                    ),
                  );
                },
                height: 50,
                minWidth: 10,
                color: Color.fromRGBO(0, 0, 0, 0.15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide.none),
                child: Icon(
                  Icons.add_a_photo,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )),
      );
}
