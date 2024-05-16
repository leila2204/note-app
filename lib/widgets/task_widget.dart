import "package:flutter/material.dart";
import "package:note_app_main/screens/edit_task_screen.dart";
import 'package:note_app_main/data/task.dart';
import 'package:time_pickerr/time_pickerr.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xfffffffff), borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: getMainContenet(),
        ),
      ),
    );
  }

  Widget getMainContenet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      value: isBoxChecked,
                      onChanged: (isChecked) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        widget.task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.task.subTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              getTimeAndEditBadgs(),
            ],
          ),
        ),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Widget getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          height: 35,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xff18DAA3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              children: [
                Text(
                  '${widget.task.time.hour}:${getMinUnderTen(widget.task.time)}',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          height: 35,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 206, 238, 229),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EditTaskScreen(
                    task: widget.task,
                  );
                }));
              },
              child: Row(
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                      color: Colors.green[800],
                    ),
                  ),
                  Spacer(),
                  Image.asset('images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 30,
        )
      ],
    );
  }

  String getMinUnderTen(DateTime time) {
    if (time.minute < 10)
      return '0${time.minute}';
    else
      return time.minute.toString();
  }
}
