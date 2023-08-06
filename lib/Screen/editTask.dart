import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../Models/model.dart';
import '../Utils/app_layout.dart';
import '../Utils/app_styles.dart';
import '../firebase/firebase.crud.dart';
import 'addTask.dart';

class EditTask extends StatefulWidget {
  final Task? task;
  const EditTask({
    super.key,
    this.task,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _subTitle = TextEditingController();
  final _description = TextEditingController();
  final _uId = TextEditingController();

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _title.value = TextEditingValue(text: widget.task!.title.toString());
    _subTitle.value = TextEditingValue(text: widget.task!.subTitle.toString());
    _description.value =
        TextEditingValue(text: widget.task!.description.toString());
    _uId.value = TextEditingValue(text: widget.task!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final TitleField = TextFormField(
      controller: _title,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Title',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
    final SubTitleField = TextFormField(
      controller: _subTitle,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Sub Title',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
    final DescField = TextFormField(
      controller: _description,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Describtion',
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(20),
            
          )),
    );
    

    final ListButton = IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPage()));
      },
      icon: Icon(
        Icons.list,
        color: Styles.orangeColor,
      ),
    );

    final UpdateButton = TextButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          var response = await FirebaseCrud.updateTasks(
              id: _uId.text,
              title: _title.text,
              subTitle: _subTitle.text,
              description: _description.text);
          if (response.code != 200) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(response.message.toString())));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(response.message.toString())));
          }
        }
      }, child: Text("Update",style:Styles.headLineStyle3,),
    
    );

    return Scaffold(
        body: Form(
      key: formKey,
      child: 
        
          Container(
            alignment: Alignment.center,
            color: Styles.kakiColor,
            child: Container(
              width: Applayout.getWidth(300),
              height: Applayout.getHeight(500),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Styles.bgColor),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleField,
                    const SizedBox(height: 25),
                    SubTitleField,
                    const SizedBox(height: 25),
                    DescField,
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [UpdateButton, ListButton],
                    )
                  ]),
            ),
          )
        
      
    ));
  }
}
