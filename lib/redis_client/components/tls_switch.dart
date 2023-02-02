import 'package:flutter/material.dart';

typedef OnTlsChanged = Function(bool);

class TlsSwitch extends StatefulWidget {
  const TlsSwitch({Key? key, required this.onTlsChanged}) : super(key: key);
  final OnTlsChanged onTlsChanged;

  @override
  State<TlsSwitch> createState() => TlsSwitchState();
}

class TlsSwitchState extends State<TlsSwitch> {
  bool tls = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 30,
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          const Text("Tls"),
          Switch(
              activeColor: Colors.blueAccent,
              value: tls,
              onChanged: (v) {
                setState(() {
                  tls = v;
                });
                widget.onTlsChanged(v);
              })
        ],
      ),
    );
  }
}
