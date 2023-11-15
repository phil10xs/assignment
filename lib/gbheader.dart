import 'package:flutter/material.dart';

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
