import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/core/app_pallete.dart';
import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/data/models/taskModel.dart';
import 'package:project_manager/features/project/presentation/cubit/project_cubit.dart';
import 'package:project_manager/features/project/presentation/cubit/tasks_cubit.dart';
import 'package:project_manager/features/project/presentation/views/homeScreen.dart';
import 'package:project_manager/features/project/presentation/widgets/circleAvatar.dart';
import 'package:project_manager/features/project/presentation/widgets/projectField.dart';

class ProjectScreen extends StatefulWidget {
  final ProjectModel project;
  const ProjectScreen({
    super.key,
    required this.project,
  });
  static route(project) =>
      MaterialPageRoute(builder: (context) => ProjectScreen(project: project));

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDateController = TextEditingController();
  var selectedUserList = [];
  var tasks;
  @override
  void initState() {
    context.read<TasksCubit>().getTasks(widget.project.id);
    context.read<ProjectCubit>().getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context, HomeScreen.route(), (route) => false);
              ;
            },
            icon: Icon(
              Icons.chevron_left,
              size: 40,
            )),
        title: Text(widget.project.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text(widget.project.description),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deadline",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(widget.project.deadline),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Progress",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(widget.project.progress.toString()),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Tasks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            BlocConsumer<TasksCubit, TasksState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is TasksLoaded) {
                  tasks = state.tasks;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.tasks[index].name),
                            leading: Container(
                                width: 50,
                                child:
                                    CircAvatar(text: state.tasks[index].name)),
                            subtitle: Text(state.tasks[index].description),
                            trailing: IconButton(
                              onPressed: () {
                                if (state.tasks[index].status == "completed") {
                                  state.tasks[index].status = "Incomplete";
                                } else {
                                  state.tasks[index].status = "completed";
                                }
                                context.read<TasksCubit>().updateTaskProgress(
                                    state.tasks[index], widget.project.id);
                              },
                              icon: Icon(
                                  state.tasks[index].status == "completed"
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              context.read<ProjectCubit>().getUsers();

              return SingleChildScrollView(
                child: StatefulBuilder(
                  builder: (context, setState) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'ADD A NEW TASK',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                decorationColor: LightTheme.brandingColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          projectField(
                            hintText: "Enter Task Name",
                            labelText: "Task Name",
                            prefixIcon: Icon(Icons.work),
                            controller: taskNameController,
                            isDate: false,
                          ),
                          projectField(
                            hintText: "Enter Task Description",
                            labelText: "Task Description",
                            prefixIcon: Icon(Icons.edit),
                            controller: taskDescriptionController,
                            isDate: false,
                          ),
                          projectField(
                            hintText: "Enter Task Deadline",
                            labelText: "Task Deadline",
                            prefixIcon: Icon(Icons.date_range),
                            controller: taskDateController,
                            isDate: true,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Assigned Users",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          BlocConsumer<ProjectCubit, ProjectState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is UsersLoaded) {
                                for (var user in state.users) {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (selectedUserList
                                              .contains(user.id)) {
                                            setState(() {
                                              selectedUserList.remove(user.id);
                                            });
                                          } else
                                            setState(() {
                                              selectedUserList.add(user.id);
                                            });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: selectedUserList
                                                            .contains(user.id)
                                                        ? Border.all(
                                                            width: 2,
                                                            color: Colors.black)
                                                        : null),
                                                child: CircAvatar(
                                                    text: user.name[0]
                                                        .toUpperCase())),
                                            Text(
                                              user.name,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }
                              }
                              return SizedBox();
                            },
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context.read<TasksCubit>().updateTasks([
                                    ...tasks,
                                    TaskModel(
                                        id: DateTime.now().toString(),
                                        name: taskNameController.text,
                                        description:
                                            taskDescriptionController.text,
                                        projectId: widget.project.id,
                                        status: "Incomplete",
                                        deadline: taskDateController.text,
                                        asignedToId: selectedUserList)
                                  ], widget.project.id);
                                },
                                child: Text('Submit'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}