import 'package:distillers_calculator/classes/batch.dart';
import 'package:distillers_calculator/classes/sqlHelper.dart';
import 'package:flutter/material.dart';

class BatchDetail extends StatefulWidget {
  final int id;
  const BatchDetail({required this.id, Key? key}) : super();
  @override
  _BatchDetailState createState() => _BatchDetailState();
}

class _BatchDetailState extends State<BatchDetail> {
  @override
  void initState() {
    super.initState();
    getAsync();
  }

  late Batch batch;
  getAsync() async {
    try {
      batch = await SQLHelper.getItem(widget.id);
    } catch (e) {
      print(e);
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (batch == null)
      return Center(child: CircularProgressIndicator());
    else
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(batch.name ?? ""), //get json fname
        ),
      );
  }
}
