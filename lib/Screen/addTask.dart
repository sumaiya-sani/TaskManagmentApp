import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_task/Screen/singleTask.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../Models/model.dart';
import '../Utils/app_layout.dart';
import '../Utils/app_styles.dart';
import '../Widget/buttons.dart';
import '../firebase/firebase.crud.dart';
import 'editTask.dart';



class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final Stream<QuerySnapshot> collection = FirebaseCrud.readTask();

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Task"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(DateTime.now()),
                              style: Styles.headLineStyle3,
                            ),
                            const Gap(10),
                            Text("Today", style: Styles.headLineStyle2),
                          ],
                        ),
                      ),
                      MyButton(
                        lable: " + Add Task",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleTask()));
                        },
                        bHight: 60,
                        bWidth: 130,
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: DatePicker(
                  DateTime(DateTime.now().year, DateTime.now().month, 1),
                  width: Applayout.getWidth(80),
                  height: Applayout.getHeight(100),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Styles.kakiColor,
                  selectedTextColor: Colors.white,
                  dateTextStyle: Styles.headLineStyle3,
                  onDateChange: (selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                ),
              )
            ],
          ),
          StreamBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // if (snapshot.hasData) {
              //   final filteredTasks = snapshot.data!.docs.where((document) {
              //     DateTime taskDate = document['dateTime'].toDate();
              //     return taskDate.year == _selectedDate.year &&
              //         taskDate.month == _selectedDate.month &&
              //         taskDate.day == _selectedDate.day;
              //   }).toList();
              if (snapshot.hasData) {
      final filteredTasks = snapshot.data!.docs.where((document) {
        Timestamp timestamp = document['dateTime'] as Timestamp;
        DateTime taskDate = timestamp.toDate();
        return taskDate.year == _selectedDate.year &&
            taskDate.month == _selectedDate.month &&
            taskDate.day == _selectedDate.day;
      }).toList();

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        final document = filteredTasks[index];
                        return Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: Applayout.getWidth(200),
                                height: Applayout.getHeight(200),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Card(
                                  color: Styles.kakiColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          document['title'].toUpperCase(),
                                          style: Styles.headLineStyle2,
                                        ),
                                        subtitle: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document['subTitle'],
                                                style: Styles.headLineStyle3
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Gap(5),
                                              Text(
                                                document['description'],
                                                style: Styles.headLineStyle3
                                                    .copyWith(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            Styles.textColor),
                                              ),
                                              Text(
                                                DateFormat('yyyy-MM-dd').format(
                                                    document['dateTime']
                                                        .toDate()),
                                                style: Styles.headLineStyle3
                                                    .copyWith(
                                                        color:
                                                            Styles.orangeColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              var dateTime;
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditTask(
                                                    task: Task(
                                                      id: document.id,
                                                        title:
                                                            document['title'],
                                                        subTitle: document[
                                                            'subTitle'],
                                                        description: document[
                                                            'description'],
                                                       ), 
                                                  ),
                                                ),
                                                (route) => false,
                                              );
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              var response =
                                                  await FirebaseCrud.deleteTask(
                                                      id: document.id);

                                              if (response.code != 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(response
                                                          .message
                                                          .toString())),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(response
                                                          .message
                                                          .toString())),
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: Applayout.getWidth(195),
                              height: Applayout.getHeight(195),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Styles.orangeColor),
                              child: Text(
                                DateFormat('HH:mm')
                                    .format(document['dateTime'].toDate()),
                                style: Styles.headLineStyle3
                                    .copyWith(color: Colors.white),
                              ),
                            ))
                          ],
                        );
                      },
                    ),
                  ),
                );
              }
              return Container();
            },
            stream: collection,
          ),
        ],
      ),
    );
  }
}
