import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterassignment/address/address_screen.dart';
import 'package:flutterassignment/address/extension.dart';
import 'package:flutterassignment/gbheader.dart';
import 'package:flutterassignment/gbtextfield.dart';
import 'package:flutterassignment/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Gigabank assignment'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController countryCtlr = TextEditingController(text: '');
  TextEditingController prefectCtlr = TextEditingController(text: '');
  TextEditingController muniCtlr = TextEditingController(text: '');
  TextEditingController streetCtlr = TextEditingController(text: '');
  TextEditingController apartCtlr = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey();

  List<String> filteredCtries = [];
  var _countries = [];
  var isValueSelected = true;

  _navigateToAddAddressScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddressScreen(title: "Address screen"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    filteredCtries = countries;
    _countries = countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              //saved user object here
              var userModel = UserModel(
                country: countryCtlr.text,
                prefecture: prefectCtlr.text,
                municipality: muniCtlr.text,
                streetAddress: streetCtlr.text,
                apartment: apartCtlr.text,
              );

              print(userModel.toJson());
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff521c78),
              borderRadius: BorderRadius.circular(16),
            ),
            width: double.infinity,
            child: Center(
                child: Text(
              'Next',
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
            height: 58,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Header(
              title: 'Registered Address',
            ),
            Row(
              children: [
                Container(
                  color: Colors.amberAccent,
                ),
                Container(
                  color: Colors.grey,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 250,
                          child: Text(
                            'Please enter information as written on your ID document.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GigaBankTextField(
                          hasSuffix: true,
                          onSelected: (v) {
                            countryCtlr.text = v;
                            filteredCtries = [];
                            setState(() {
                              isValueSelected = false;
                            });
                          },
                          title: 'Country',
                          ctlr: countryCtlr,
                          searchedValue: filteredCtries,
                          hasSearcableValue: isValueSelected,
                          onChanged: (v) {
                            setState(() {
                              isValueSelected = true;
                              filteredCtries = countries
                                  .where((element) => element
                                      .toString()
                                      .toLowerCase()
                                      .contains(countryCtlr.text.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GigaBankTextField(
                          title: 'Prefecture',
                          ctlr: prefectCtlr,
                          searchedValue: [],
                          hasSuffix: false,
                          hasSearcableValue: false,
                          onChanged: (v) {},
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GigaBankTextField(
                          title: 'Municipality',
                          ctlr: muniCtlr,
                          searchedValue: [],
                          hasSuffix: false,
                          hasSearcableValue: false,
                          onChanged: (v) {},
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GigaBankTextField(
                          title: 'Street Address (sub-area block house)',
                          ctlr: streetCtlr,
                          searchedValue: [],
                          hasSuffix: false,
                          hasSearcableValue: false,
                          onChanged: (v) {
                            List<String> parts = v.split('-');
                            print(parts.length);
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GigaBankTextField(
                          title: 'Apartment, suite or unit',
                          ctlr: apartCtlr,
                          searchedValue: [],
                          hasSuffix: false,
                          hasSearcableValue: false,
                          onChanged: (v) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
