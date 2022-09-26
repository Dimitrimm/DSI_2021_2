import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TelaEdicao extends StatefulWidget {
  const TelaEdicao({Key? key}) : super(key: key);

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [],
      ),
    );
  }
}
