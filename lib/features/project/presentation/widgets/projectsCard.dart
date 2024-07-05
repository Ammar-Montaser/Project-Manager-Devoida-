import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/features/project/presentation/cubit/tasks_cubit.dart';
import 'package:project_manager/features/project/presentation/widgets/circleAvatar.dart';

class ProjectsCard extends StatelessWidget {
  final state;
  final index;
  final id;
  const ProjectsCard({super.key, this.state, this.index, this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          state.tasks[index].name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              decoration: state.tasks[index].status == "completed"
                  ? TextDecoration.lineThrough
                  : null),
        ),
        leading: Container(
            width: 50,
            child: CircAvatar(text: state.tasks[index].name[0].toUpperCase())),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.tasks[index].description,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  decoration: state.tasks[index].status == "completed"
                      ? TextDecoration.lineThrough
                      : null),
            ),
            Text(
              "Deadline: " + state.tasks[index].deadline,
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Assignee: " + state.tasks[index].asignedToId.join(", "),
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            if (state.tasks[index].status == "completed") {
              state.tasks[index].status = "Incomplete";
            } else {
              state.tasks[index].status = "completed";
            }
            context
                .read<TasksCubit>()
                .updateTaskProgress(state.tasks[index], id);
          },
          icon: Icon(state.tasks[index].status == "completed"
              ? Icons.check_box
              : Icons.check_box_outline_blank),
        ),
      ),
    );
  }
}
