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
                  padding: const EdgeInsets.only(left: 16),
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
              SizedBox(
                width: 16,
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class GigaBankTextField extends StatefulWidget {
  final TextEditingController ctlr;
  final Function(String) onChanged;
  final String title;
  final bool? hasSearcableValue;
  final bool? hasSuffix;
  final List<String>? searchedValue;
  final Function(String)? onSelected;

  const GigaBankTextField({
    super.key,
    required this.ctlr,
    required this.onChanged,
    required this.title,
    this.hasSearcableValue = false,
    this.searchedValue,
    this.onSelected,
    this.hasSuffix = false,
  });

  @override
  State<GigaBankTextField> createState() => _GigaBankTextFieldState();
}

class _GigaBankTextFieldState extends State<GigaBankTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.ctlr,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [],
          validator: (v) =>
              v!.fieldvalidation(field: widget.title, value: widget.ctlr.text),
          onChanged: (value) => {
            widget.onChanged(value),
          },
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            contentPadding: const EdgeInsets.only(
              top: 14.0,
              bottom: 12.0,
              left: 5.0,
              right: 14.0,
            ),

            // fillColor: Colors.white70,
            suffixIcon: widget.hasSuffix! ? const Icon(Icons.search) : null,
            hintText: widget.title,
            hintStyle: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        widget.ctlr.text.isNotEmpty & widget.hasSearcableValue!
            ? Container(
                height: 130,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0;
                          i < widget.searchedValue!.length;
                          i++) ...[
                        widget.searchedValue!.isEmpty
                            ? SizedBox()
                            : ListTile(
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                                onTap: () {
                                  widget.onSelected!(widget.searchedValue![i]);
                                },
                                title: Text(
                                  widget.searchedValue![i],
                                ),
                              ),
                      ],
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
