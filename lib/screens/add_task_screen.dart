import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app_main/data/task_type.dart';
import 'package:note_app_main/data/task.dart';
import 'package:note_app_main/utility/utility.dart';
import 'package:note_app_main/widgets/task_type_item.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();
  final box = Hive.box<Task>('taskBox');
  DateTime? _time;
  int _selectedTaskTypeItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: controllerTaskTitle,
                focusNode: negahban1,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: 'عنوان تسک',
                  labelStyle: TextStyle(
                    //fontFamily: 'GM',
                    fontSize: 20,
                    color: negahban1.hasFocus ? Color(0xff18DAA3) : Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                        BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xff18DAA3),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: controllerTaskSubTitle,
                maxLines: 2,
                focusNode: negahban2,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: 'توضیحات تسک',
                  labelStyle: TextStyle(
                    //fontFamily: 'GM',
                    fontSize: 20,
                    color: negahban2.hasFocus ? Color(0xff18DAA3) : Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                        BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xff18DAA3),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: CustomHourPicker(
              title: 'زمان تسک را انتخاب کن',
              negativeButtonText: 'حذف کن',
              positiveButtonText: 'انتخاب زمان',
              elevation: 2,
              titleStyle: TextStyle(
                color: Color(0xff18DA3A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              negativeButtonStyle: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              positiveButtonStyle: TextStyle(
                color: Color(0xff18DA3A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              onPositivePressed: (context, time) {
                _time = time;
              },
              onNegativePressed: (context) {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getTaskTypeList().length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTaskTypeItem = index;
                      });
                    },
                    child: TaskTypeItemList(
                      taskType: getTaskTypeList()[index],
                      index: index,
                      selectedItemList: _selectedTaskTypeItem,
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              backgroundColor: Color(0xff18DAA3),
            ),
            onPressed: () {
              String taskTitle = controllerTaskTitle.text;
              String TaskSubTitle = controllerTaskSubTitle.text;
              addTask(taskTitle, TaskSubTitle);
              Navigator.of(context).pop();
            },
            child: Text(
              'ایجاد تسک',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
        ],
      )),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(
      title: taskTitle,
      subTitle: taskSubTitle,
      time: _time!,
      taskType: getTaskTypeList()[_selectedTaskTypeItem],
    );
    box.add(task);
    print(box.get(2)!.title);
  }
}

