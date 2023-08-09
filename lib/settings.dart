
import 'dart:convert';

import 'package:Expense_management/main.dart';
import 'package:Expense_management/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_Page.dart';
import 'package:http/http.dart' as http;
import 'confirm_dialog.dart';



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController name_controler = TextEditingController();
  //


  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(
          12.0,
        ),
        children: [
          ListTile(
            onTap: () async {
              bool answer = await showConfirmDialog(context, "Warning",
                  "This is irreversible. Your entire data will be Lost");
              if (answer) {
               // await dbHelper.cleanData();
                await delrecord();
                Navigator.of(context).pop();
              }
            },
            tileColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            title: Text(
              "Clean Data",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: Text(
              "This is irreversible",
            ),
            trailing: Icon(
              Icons.delete_forever,
              size: 32.0,
              color: Colors.black87,
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          // ListTile(
          //   onTap: () async {
          //    // String nameEditing = "";
          //     String? name = await showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         backgroundColor: Colors.grey[300],
          //         title: Text(
          //           "Enter new name",
          //         ),
          //         content: Container(
          //           decoration: BoxDecoration(
          //             color: Colors.white70,
          //             borderRadius: BorderRadius.circular(
          //               12.0,
          //             ),
          //           ),
          //           padding: EdgeInsets.symmetric(
          //             vertical: 8.0,
          //             horizontal: 16.0,
          //           ),
          //           child: TextFormField(
          //             controller: name_controler,
          //             decoration: InputDecoration(
          //               hintText: get_username,
          //               border: InputBorder.none,
          //             ),
          //             style: TextStyle(
          //               fontSize: 20.0,
          //             ),
          //             maxLength: 12,
          //             onChanged: (val) {
          //             ///  nameEditing = val;
          //             },
          //           ),
          //         ),
          //         actions: [
          //           ElevatedButton(
          //             onPressed: () {
          //               Update();
          //               Navigator.of(context).pop();
          //             //  Navigator.of(context).pop(nameEditing);
          //             },
          //             child: Text(
          //               "OK",
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //     //
          //     if (name != null && name.isNotEmpty) {
          //       //DbHelper dbHelper = DbHelper();
          //      // await dbHelper.addName(name);
          //     }
          //   },
          //   tileColor: Colors.white,
          //   contentPadding: EdgeInsets.symmetric(
          //     vertical: 12.0,
          //     horizontal: 20.0,
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(
          //       8.0,
          //     ),
          //   ),
          //   title: Text(
          //     "Change Name",
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontWeight: FontWeight.w800,
          //     ),
          //   ),
          //   subtitle: Text(
          //     "Welcome {newname}",
          //   ),
          //   trailing: Icon(
          //     Icons.change_circle,
          //     size: 32.0,
          //     color: Colors.black87,
          //   ),
          // ),
          //
          SizedBox(
            height: 20.0,
          ),
          //

          SizedBox(
            height: 20.0,
          ),
          ListTile(
            onTap: ()async{
              final SharedPreferences sharedpreferences =
              await SharedPreferences.getInstance();
              sharedpreferences.remove('admin_id');
             // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AddName()));
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/log', (Route<dynamic> route) => false);

            },



            tileColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),

            trailing: Icon(
              Icons.exit_to_app,
              size: 32.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> delrecord() async {
    String url = "http://$ip_address/Expense_Management/clean_all_data.php";
    var res = await http.post(Uri.parse(url), body: {

    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home_Page()));
      });
      print("success");
    }
  }




  // Update() async {
  //   final response = await http.post(
  //       Uri.parse("http://$ip_address/Expense_Management/update_data.php"),
  //       body: {
  //         "id": Admin_key,
  //         "username": name_controler.text,
  //
  //       });
  //   if (response.statusCode == 200) {
  //
  //
  //
  //     final snackBar = await SnackBar(
  //       content: const Text('Event updated successfully!'),
  //       action: SnackBarAction(
  //         label: 'Ok',
  //         onPressed: () {
  //           //Navigator.pop(context);
  //           // Some code to undo the change.
  //         },
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else {
  //     print("not");
  //     final snackBar = await SnackBar(
  //       content: const Text('Event updation failed!'),
  //       action: SnackBarAction(
  //         label: 'Ok',
  //         onPressed: () {
  //           //Navigator.pop(context);
  //           // Some code to undo the change.
  //         },
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  //   setState(() {});
  // }


}
