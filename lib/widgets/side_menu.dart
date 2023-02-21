import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/domain/model/project.dart';
import 'package:flutter_b_ui_layout/widgets/side_menu_item.dart';
import 'package:flutter_b_ui_layout/widgets/user_info_card.dart';

import '../domain/model/task.dart';

class SideMenu extends StatefulWidget {
  SideMenu({super.key});
  final List<Project> projects = [
    Project(
      id: 1,
      title: 'First project',
      tasks: [
        Task(
          id: 1,
          title: 'First Task',
          description: 'this is my first task',
          dateFinish: DateTime.now(),
          isDone: true,
        ),
        Task(
          id: 2,
          title: 'Secont Task',
          description: 'this is my second task',
          dateFinish: DateTime.now(),
          isDone: false,
        ),
      ],
    ),
    Project(
      id: 2,
      title: 'Second project',
      tasks: [
        Task(
          id: 1,
          title: 'First Task',
          description: 'this is my third task',
          dateFinish: DateTime.now(),
          isDone: false,
        ),
        Task(
          id: 2,
          title: 'Secont Task',
          description: 'this is my fourth task',
          dateFinish: DateTime.now(),
          isDone: false,
        ),
      ],
    ),
  ];

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  
  Project? selectedProject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color:const Color.fromARGB(255, 17, 0, 63),
        child: SafeArea(
          child: Column(
            children: [
              const UserInfoCard(
                name: 'Artur Khasanov',
                profession: 'Flutter Developer',
              ),
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    'Projects',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              ...widget.projects.map(
                (project) => SideMenuItem(
                  project: project,
                  onTap: () {
                    setState(() {
                      selectedProject = project;
                    });
                  },
                  isActive: selectedProject == project,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
