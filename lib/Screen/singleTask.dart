import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../Utils/app_layout.dart';
import '../Utils/app_styles.dart';
import '../Widget/buttons.dart';
import '../firebase/firebase.crud.dart';
import 'addTask.dart';

class SingleTask extends StatefulWidget {
  const SingleTask({super.key});

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
 DateTime dateTime = DateTime.now();
  
  //final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  
   int _selectedChoiceIndex = 0;

  final List<String> _choices = [
    'Choice 1',
    'Choice 2',
    'Choice 3',
  ];

  final TextEditingController _title = TextEditingController();
  final TextEditingController _subTitle = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final titleField = TextField(
      controller: _subTitle,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
      ),
    );
    final dateField = TextField(
      controller: _title,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
      ),
    );
    final descField = TextField(
      controller: _description,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
      ),
    );

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Applayout.getHeight(300),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  color: Styles.kakiColor),
              child: Container(
                margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create new Task ",
                        style:
                            GoogleFonts.roboto(textStyle: Styles.headLineStyle1)),
                    Gap(10),
                    Text("Task ", style: Styles.headLineStyle3),
                    titleField,
                    Gap(10),
                    Text(
                      "Sub Task ",
                      style: Styles.headLineStyle3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: dateField),
                        //Text("hi"),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Styles.orangeColor),
                          child: IconButton(
                               onPressed: () async {
                          DateTime? dataPicker = await showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2025));
                          if (dateTime == null) {
                            return;
                          }
      
                          TimeOfDay? pickerTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: dateTime.hour, minute: dateTime.minute));
                                  if(pickerTime==null){
                                    return;
                                  }
      
                                  final pickerDateAndTime=DateTime(
                                    dataPicker!.year,
                                    dataPicker.month,
                                    dataPicker.day,
                                    pickerTime.hour,
                                    pickerTime.minute,
                                   
                                  
                                   
      
                                  );
                                  
                          setState(() {
                            dateTime = pickerDateAndTime;
                            print(dateTime);
                          });
                        },
                              icon: Icon(
                                Icons.date_range_rounded,
                                color: Colors.white,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(20),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
               
                  
                   Expanded(
                    child: Container(
                     
                      
                      
                      
                      child: Column(children: [
                        Text("Task Date "),
                         const  Gap(10),

                        Text('${dateTime.day}/${dateTime.month}/${dateTime.year}',style: GoogleFonts.lato(textStyle: Styles.headLineStyle3),),
                      ],)
                    )),
                    Expanded(
                    child: Container(
                     
        
                      child: Column(children: [
                        Text("Task Time"),
                       const  Gap(10),
                        Text('${dateTime.hour}:${dateTime.minute}',style: GoogleFonts.lato(textStyle: Styles.headLineStyle3),),
                      ],),
      
      
      
                      
                    )),
                  
                ],
              ),
            ),
            Gap(60),
      
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description ",
                    style: Styles.headLineStyle3,
                  ),
                     descField,
                     Gap(10),
                     
                ],
              ),
            ),
             
                  
                  
                  
            
            
         Gap(100),
            MyButton(lable: "Create Task", onTap: () async
            
            {
      if(_title.text==null ||_title.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("add something")));
      
      }if(_subTitle.text==null ||_subTitle.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("add something")));
      
      }if(_description.text==null ||_description.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("add something")));
      
      }if(dateTime==null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("add something")));
      
      }else{
        var respone=await FirebaseCrud.addTask(dateTime: dateTime, title: _title.text, subTitle: _subTitle.text, description: _description.text, );
        if(respone.code !=200){
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(respone.message.toString())));
                            }else{
      
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(respone.message.toString())));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
                            }
      }
      
            }, bHight: 60, bWidth: 300,),
          ],
      
      
        ),
      ),
    );
  }
}
