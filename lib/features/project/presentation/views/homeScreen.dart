import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_manager/core/app_pallete.dart';
import 'package:project_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/features/auth/presentation/views/login.dart';
import 'package:project_manager/features/project/presentation/cubit/project_cubit.dart';
import 'package:project_manager/features/project/presentation/views/projectScreen.dart';
import 'package:project_manager/features/project/presentation/widgets/projectField.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => HomeScreen());

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final projectNameController = TextEditingController();
  final projectDeadlineController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  late var projects;

  @override
  void initState() {
    context.read<ProjectCubit>().getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Home"), centerTitle: true, actions: [
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushReplacement(context, loginScreen.route());
            }
          },
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  context.read<AuthCubit>().logoutUser();
                },
                icon: Icon(Icons.logout));
          },
        ),
      ]),
      body: BlocConsumer<ProjectCubit, ProjectState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProjectInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProjectLoaded) {
            projects = state.projects;
            if (projects.length == 0) {
              return Center(
                child: Text("No Projects Found"),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context, ProjectScreen.route(projects[index]))
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Container(
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      projects[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Deadline",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.end,
                                      ),
                                      Text(
                                        projects[index].deadline,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  projects[index].description,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    projects[index].progress.toString() +
                                        "% Completed",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ProjectError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Loading..."),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'ADD A NEW PROJECT',
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
                        hintText: "Enter Project Name",
                        labelText: "Project Name",
                        prefixIcon: Icon(Icons.work),
                        controller: projectNameController,
                        isDate: false,
                      ),
                      projectField(
                        hintText: "Enter Project Description",
                        labelText: "Project Description",
                        prefixIcon: Icon(Icons.edit),
                        controller: projectDescriptionController,
                        isDate: false,
                      ),
                      projectField(
                        hintText: "Enter Project Deadline",
                        labelText: "Project Deadline",
                        prefixIcon: Icon(Icons.date_range),
                        controller: projectDeadlineController,
                        isDate: true,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<ProjectCubit>().createProject(
                                  projectNameController.text,
                                  projectDescriptionController.text,
                                  projectDeadlineController.text);
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ),
                    ],
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
