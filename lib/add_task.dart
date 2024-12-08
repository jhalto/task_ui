import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNodeProject = FocusNode();
  final FocusNode _focusNodeTitle = FocusNode();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _focusNodeProject.dispose();
    _focusNodeTitle.dispose();
    _projectController.dispose();
    _titleController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true, // Allows the modal to resize for the keyboard
          context: context,
          builder: (context) {
            // Focus the first text field after a short delay
            Future.delayed(Duration.zero, () {
              _focusNodeProject.requestFocus();
            });
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,),
              child: SizedBox(
                height: 100,
                child: PageView(
                  controller: _pageController, // Link the PageController
                  children: [
                    BottomForm(
                      hint: "Project Name",
                      function: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 1

                          ),
                          curve: Curves.easeInOut,

                        );
                        Future.delayed(const Duration(milliseconds: 1), () {
                          _focusNodeTitle.requestFocus();
                        });
                      },
                      focusNode: _focusNodeProject,
                      textEditingController: _projectController,
                    ),
                    BottomForm(
                      hint: "Title",
                      function: () {
                        // Final action
                        _focusNodeTitle.unfocus();
                      },
                      focusNode: _focusNodeTitle,
                      textEditingController: _titleController,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class BottomForm extends StatelessWidget {
  const BottomForm({
    super.key,
    required this.function,
    required this.focusNode,
    required this.textEditingController,
    required this.hint,
  });

  final VoidCallback function;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        16.0,

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onEditingComplete: function, // Trigger the navigation function
            focusNode: focusNode,

            controller: textEditingController,
            decoration: InputDecoration(
                hintText: hint,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent
                    )
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent
                    )
                )
            ),
          ),
        ],
      ),
    );
  }
}
