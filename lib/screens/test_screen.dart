import 'package:app_marketing_version_2/view_models/share_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String key = 'qwe';
  String key1 = 'qwee12';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await context.read<SharePreference>().save(key, 'value');
              },
              child: Text(
                "save",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var read = await context.read<SharePreference>().read(key);

                if (read != null) {
                  print(await context.read<SharePreference>().read(key));
                } else {
                  print('null');
                }
              },
              child: Text(
                "read",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // var remove = await context.read<SharePreference>().remove(key);
                //  if (remove != null) {
                //   print(await context.read<SharePreference>().read(key));
                // } else {
                //   print('null');
                // }
                await context.read<SharePreference>().remove(key);
              },
              child: Text(
                "remove",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
