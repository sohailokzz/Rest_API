import 'package:flutter/material.dart';
import 'package:rest_api/controller/todo_controller.dart';
import 'package:rest_api/models/todo.dart';
import 'package:rest_api/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var todo = snapshot.data?[index];
                return Container(
                  height: 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('${todo?.id}'),
                        flex: 1,
                      ),
                      Expanded(
                        child: Text('${todo?.title}'),
                        flex: 3,
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                todoController.updatePatchCompleted(todo!).then(
                                  (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(value),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: buildCallContainer(
                                'Patch',
                                const Color(0xFFFFE0B2),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                todoController.updatePutCompleted(todo!);
                              },
                              child: buildCallContainer(
                                'Put',
                                const Color(0xFFE1BEE7),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                todoController.deleteTodo(todo!).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      content: Text('$value'),
                                    ),
                                  );
                                });
                              },
                              child: buildCallContainer(
                                'Delete',
                                const Color(0xFFFFCDD2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Todo todo = Todo(userId: 3, title: 'Sample Post', completed: false);
          todoController.postTodo(todo);
        },
      ),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
