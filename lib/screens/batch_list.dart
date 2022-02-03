import 'package:distillers_calculator/classes/sql_helper.dart';
import 'package:distillers_calculator/model/batch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'batch_detail.dart';

class BatchList extends StatefulWidget {
  const BatchList({Key? key}) : super(key: key);

  @override
  _BatchListState createState() => _BatchListState();
}

class _BatchListState extends State<BatchList> {
  // All journals
  List<Batch> _journals = [];

  bool _isLoading = true;

  DateTime selectedDate = DateTime.now();
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getBatches();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(Batch? batch) async {
    if (batch != null) {
      // id == null -> create new item
      // id != null -> update an existing item

      _titleController.text = batch.name;
      _descriptionController.text = batch.description;
    } else {
      _titleController.text = "";
      _descriptionController.text = "";
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("date Batch Started"),
                  SfDateRangePicker(
                      showActionButtons: false, onSelectionChanged: setDate),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (batch == null) {
                        await _addItem();
                      } else {
                        await _updateItem(batch.id);
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descriptionController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(batch == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            )));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createBatch(
        _titleController.text, _descriptionController.text, selectedDate);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateBatch(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Delete an item
  // ignore: unused_element
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batches'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Dismissible(
                confirmDismiss: (DismissDirection dismissDirection) async {
                  return await _showConfirmationDialog(context, 'archive') ==
                      true;
                },
                direction: DismissDirection.startToEnd,
                secondaryBackground: Container(),
                background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      size: 50,
                    )),
                key: ValueKey<Batch>(_journals[index]),
                onDismissed: (DismissDirection direction) {
                  SQLHelper.archiveBatch(_journals[index].id);
                  _journals.removeAt(index);
                },
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      iconSize: 50,
                      color: Colors.green,
                      splashColor: Colors.purple,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BatchDetail(batch: _journals[index]),
                          ),
                        );
                      },
                    ),
                    title: Text(_journals[index].name),
                    subtitle: Text(DateFormat('MMM-dd')
                        .format(_journals[index].batchStartedDateAsDate)),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.edit,
                      ),
                      iconSize: 50,
                      color: Colors.green,
                      splashColor: Colors.purple,
                      onPressed: () {
                        _showForm(_journals[index]);
                      },
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context, String action) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to $action this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }

  void setDate(
      DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
    selectedDate = dateRangePickerSelectionChangedArgs.value;
  }
}
