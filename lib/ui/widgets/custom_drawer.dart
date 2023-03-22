import 'package:flutter/material.dart';
import 'package:flutter_b_ui_layout/domain/model/project.dart';
import 'package:flutter_b_ui_layout/ui/widgets/log_out_button.dart';
import 'package:flutter_b_ui_layout/ui/widgets/side_menu_item.dart';
import 'package:flutter_b_ui_layout/ui/widgets/user_info_card.dart';

import '../../domain/model/task.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});
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
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Project? selectedProject;

  @override
  Widget build(BuildContext context) {
    return Material(

      child: Container(
        width: 296,
        height: double.infinity,
        color: const Color.fromARGB(255, 17, 0, 63),
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
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
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => SideMenuItem(
                      project: widget.projects[index],
                      onTap: () {
                        setState(() {
                          selectedProject = widget.projects[index];
                        });
                      },
                      isActive: selectedProject == widget.projects[index]),
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: widget.projects.length),
              const Spacer(),
              const LogOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
