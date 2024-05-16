import 'package:note_app_main/data/task_type.dart';
import 'package:note_app_main/data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'images/meditate.png',
        title: 'تمرکز',
        taskTypeEnum: TaskTypeEnum.focus),
         TaskType(
        image: 'images/social_frends.png',
        title: 'ارتباط',
        taskTypeEnum: TaskTypeEnum.date),
        TaskType(
        image: 'images/hard_working.png',
        title: 'کار',
        taskTypeEnum: TaskTypeEnum.working,)

  ];
  return list;
}
