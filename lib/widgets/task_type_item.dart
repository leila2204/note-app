import 'package:flutter/material.dart';
import 'package:note_app_main/data/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {super.key,
      required this.taskType,
      required this.index,
      required this.selectedItemList});

  TaskType taskType;
  int index;
  int selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (selectedItemList==index) ?Colors.green:Colors.white,
        border: Border.all(
            color: (selectedItemList == index) ? Colors.green : Colors.grey,
            width: (selectedItemList == index) ?3 : 2,),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(taskType.title,style: TextStyle(color: (selectedItemList==index) ?Colors.white :Colors.black,fontSize: (selectedItemList==index) ?20 :18,),),
        ],
      ),
    );
  }
}
