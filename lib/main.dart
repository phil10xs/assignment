import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterassignment/address/address_screen.dart';
import 'package:flutterassignment/address/extension.dart';

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
  List<String> filteredCtries = [];
  var _countries = [];

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
            Container(
              padding: const EdgeInsets.all(16.0),
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
                  TextFormField(
                    controller: countryCtlr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [],
                    validator: (v) => v!.fieldvalidation(field: "Country"),
                    onChanged: (value) => {
                      setState(() {
                        filteredCtries = countries
                            .where((element) => element
                                .toString()
                                .toLowerCase()
                                .contains(countryCtlr.text.toLowerCase()))
                            .toList();
                      }),
                    },
                    decoration: InputDecoration(
                      labelText: "Country",
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.only(
                        top: 14.0,
                        bottom: 12.0,
                        left: 5.0,
                        right: 14.0,
                      ),
                      filled: true,
                      // fillColor: Colors.white70,
                      suffixIcon: Icon(Icons.search),
                      hintText: "Country",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  countryCtlr.text.isNotEmpty
                      ? Container(
                          height: 130,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var i = 0;
                                    i < filteredCtries.length;
                                    i++) ...[
                                  filteredCtries.isEmpty
                                      ? SizedBox()
                                      : ListTile(
                                          visualDensity:
                                              const VisualDensity(vertical: -3),
                                          onTap: () {
                                            countryCtlr.text =
                                                filteredCtries[i];
                                            setState(() {});
                                          },
                                          title: Text(
                                            filteredCtries[i],
                                          ),
                                        ),
                                ],
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),

                  // ElevatedButton(
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: Colors.white,
                  //     padding: const EdgeInsets.all(16.0),
                  //     textStyle: const TextStyle(fontSize: 20),
                  //     backgroundColor: Colors.blue,
                  //     elevation: 5,
                  //   ),
                  //   onPressed: _navigateToAddAddressScreen,
                  //   child: const Text('Add address',
                  //       style: TextStyle(color: Colors.white)),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  final String? title;
  final Function? onNavBack;
  final bool? enableNav;
  final String? icon;
  final bool? hideBackButton;

  const Header({
    super.key,
    this.title = '',
    this.onNavBack,
    this.enableNav,
    this.icon,
    this.hideBackButton = false,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: const Color(0xff521c78),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widget.hideBackButton!)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () => widget.enableNav!
                        ? Navigator.of(context).pop()
                        : widget.onNavBack!(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              const Spacer(),
              Text(widget.title!,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
