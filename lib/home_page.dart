//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modal.dart';
import 'package:todo_app/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add ToDo List"),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "Write to do item"),
            ),
            actions: [
              /////submitButton////
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    context.read<TODOProvider>().addToDoList(TODOModal(
                        title: _textController.text, isCompleted: false));

                    _textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Submit")),

              /////////cancel button/////////
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TODOProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .2,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: const Center(
                  child: Text(
                "TODO List",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: provider.allTODOList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          tileColor: Colors.blueGrey.shade100,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                            onTap: () {
                              provider
                                  .todoStatusChange(provider.allTODOList[index]);
                            },
                            title: Text(
                              provider.allTODOList[index].title,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  decoration:
                                      provider.allTODOList[index].isCompleted ==
                                              true
                                          ? TextDecoration.lineThrough
                                          : null),
                            ),
                            leading: MSHCheckbox(
                                size: 30,
                                style: MSHCheckboxStyle.stroke,
                                value: provider.allTODOList[index].isCompleted,
                                onChanged: (selected) {
                                  provider.todoStatusChange(
                                      provider.allTODOList[index]);
                                }),


                            ////////delete button

                            trailing: IconButton(
                                onPressed: () {
                                  provider.removeToDoList(provider.allTODOList[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ))),
                      );
                    })),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () {
          _showDialog();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
