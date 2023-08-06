import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Utils/app_layout.dart';
import '../utils/app_styles.dart';

class InputSingleField extends StatelessWidget {
  final String title;
  final String hint;
  
  final Widget? widget;
  final TextEditingController? myController;
  const InputSingleField(
      {Key? key,
      required this.title,
      required this.hint,
     
      this.widget,
       required this.myController,
      
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Applayout.getHeight(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Styles.headLineStyle3.copyWith(color: Colors.black)),
            Container(
              height: Applayout.getHeight(52),
              margin: EdgeInsets.only(top: Applayout.getHeight(8)),
              padding: EdgeInsets.only(left: Applayout.getWidth(14)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1.5)),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: myController,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey[600],
                    
                   
                    style: Styles.headLineStyle3,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: Styles.headLineStyle4,
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                    ),
                  )),
                  widget == null
                      ? Container()
                      : Container(
                          child: widget,
                        )
                ],
              ),
            )
          ],
        ));
  }
}
