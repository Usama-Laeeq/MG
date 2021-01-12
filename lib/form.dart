import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Constants.dart';
import 'package:mailer/smtp_server.dart';

class MonarchForm extends StatefulWidget {
  @override
  _MonarchFormState createState() => _MonarchFormState();
}

class _MonarchFormState extends State<MonarchForm> {
  // String firstName, lastName, phoneNumber, address, itemDescription;
  bool status = false;
  bool _saveData = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController itemDescription = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');


  sendmail() async {
    String username = 'recyclingmonarch@gmail.com';
    String password = 'Dewana44';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'MonarchRecycling')
      ..recipients.add('recyclingmonarch@gmail.com')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Welcome to ${firstName.text+" "+lastName.text} in MonarchRecycling ${formatter.format(now)}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h2>MonarchRecycling New User Form</h2>\n<h3>${firstName.text+" "+lastName.text}</h3>\n<h4>${phoneNumber.text}</h4>\n<h4>${address.text}</h4>\n<p>${itemDescription.text}</p>"
    ;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void addData(){
   try{
     _fireStore.collection('UserInfo').add({
       'firstName' : firstName.text,
       'lastName' : lastName.text,
       'phoneNumber' : phoneNumber.text,
       'address' : address.text,
       'itemDescription' : itemDescription.text,
     }).then((value)  {
       // showInSnackBar();
       clearTextInput();
       setState(() {
         _saveData = false;
       });
       // showInSnackBar();
       print('form data is given as');
       print(value);
     });
   }catch(e){
     print('form data has thrown error and error is');
     print(e);
   }
  }
  void clearTextInput(){
    firstName.clear();
    lastName.clear();
    phoneNumber.clear();
    address.clear();
    itemDescription.clear();
  }
  // void showInSnackBar() {
  //   // scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Data is saved')));
  //   scaffoldKey.currentState.showSnackBar(
  //       new SnackBar(duration: new Duration(seconds: 3), content:
  //       new Text('Data is Saved')
  //       ));
  // }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    address.dispose();
    itemDescription.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0XFF0d8500),
      body: ModalProgressHUD(
        inAsyncCall: _saveData,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              decoration:  BoxDecoration(
                image:  DecorationImage(image:  AssetImage("assets/formBackground.png"), fit: BoxFit.cover,),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: width/15,left:  width/20,right:  width/20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('E-WASTE',style: TextStyle(fontSize:  width/14,color:Colors.white,fontWeight: FontWeight.w600),),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 20),
                          child: Text('RECYCLING',style: TextStyle(fontSize:  width/12,color:Colors.white,fontWeight: FontWeight.w600),),
                        ),
                        Text('Schedule Your Pickup',style: TextStyle(color: Colors.white,fontSize:  width/13,fontWeight: FontWeight.w400),),
                        Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FieldName(name: 'First Name',),
                                        SizedBox(
                                          width: width/2.6,
                                          height: height/14,
                                          child: Expanded(
                                            child: TextFormField(
                                              controller: firstName,
                                              // onChanged: (value){
                                              //   firstName = value;
                                              // },
                                              validator: (value){
                                                if(value == null || value.length < 2)
                                                  return 'Please Enter Name';
                                                else
                                                  return null;
                                              },
                                              decoration: TextFieldDecoration.copyWith(
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                                  counterText: '.',
                                                counterStyle: TextStyle(color: Colors.transparent)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5,bottom: 5),
                                          child: Text('Last Name',style: TextStyle(color: Colors.white,fontSize: width/24),),
                                        ),
                                        Container(
                                          width: width/2.6,
                                          height: height/14,
                                          child: Expanded(
                                            child: TextFormField(
                                              controller: lastName,
                                              // onChanged: (value){
                                              //   lastName = value;
                                              // },
                                              decoration: TextFieldDecoration.copyWith(
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                                  counterText: '.',
                                                  counterStyle: TextStyle(color: Colors.transparent)                                          ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                               Column(
                                 children: [
                                   FieldName(name: 'Phone Number',),
                                   Container(
                                     height: height/14,
                                     child: TextFormField(
                                       keyboardType: TextInputType.phone,
                                       controller: phoneNumber,
                                       // onChanged: (value){
                                       //   phoneNumber = value;
                                       // },
                                       validator: (value){
                                         if(value == null || value.length < 11)
                                           return 'Please Enter Proper Number';
                                         else
                                           return null;
                                       },
                                       decoration: TextFieldDecoration.copyWith(
                                         contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                           counterText: '.',
                                           counterStyle: TextStyle(color: Colors.transparent)
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                                FieldName(name: 'Address/Buzzer',),
                                TextFormField(
                                  controller: address,
                                  // onChanged: (value){
                                  //   address = value;
                                  // },
                                  maxLines: 2,
                                  maxLength: 50,
                                  validator: (value){
                                    if(value == null || value.length < 6)
                                      return 'Please Enter Proper address';
                                    else
                                      return null;
                                  },
                                  decoration: TextFieldDecoration.copyWith(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                      counterText: '.',
                                      counterStyle: TextStyle(color: Colors.transparent)
                                  ),
                                ),
                                FieldName(name: 'Item Description',),
                                TextFormField(
                                  maxLines: 6,
                                  controller: itemDescription,
                                  // onChanged: (value){
                                  //   itemDescription = value;
                                  // },
                                  maxLength: 250,
                                  validator: (value){
                                    if(value == null || value.length < 11)
                                      return 'Please Enter Description';
                                    else
                                      return null;
                                  },
                                  decoration: TextFieldDecoration.copyWith(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: FlatButton(
                                    height: height/20,
                                    minWidth: width,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Text('Send Message',style: TextStyle(color: Colors.black,fontSize: width/20,fontWeight: FontWeight.w400),),
                                    onPressed:
                                    ()async{
                                      if(formKey.currentState.validate())
                                        {
                                          setState(() {
                                            _saveData = true;
                                          });
                                          addData();
                                          sendmail();
                                          // scaffoldKey.currentState.showSnackBar(
                                          //     new SnackBar(duration: new Duration(seconds: 6), content:
                                          //     new Row(
                                          //       children: <Widget>[
                                          //         new CircularProgressIndicator(),
                                          //         Padding(
                                          //           padding: const EdgeInsets.only(left: 10),
                                          //           child: Text('Saving Data'),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     ));
                                          print('Everything is ok');
                                        }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FieldName extends StatelessWidget {
  String name;
  FieldName({this.name});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      child: Row(
        children: [
          Text(name,style: TextStyle(color: Colors.white,fontSize: width/24),),
          Text('*',style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}
