import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/task/data/models/param/add_new_task_param.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';
import 'package:todoapp/features/task/data/repositories/default_task_repository.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';
import 'package:todoapp/features/task/domain/usecases/add_new_task_usecase.dart';

class MockTodoRepository extends Mock implements DefaultTaskRepository {}

void main() {
  late AddNewTaskUsecase usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = AddNewTaskUsecase(mockTodoRepository);
  });
  final taskModel =
      TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);

  final gettaskEntity =
      GetTaskEntity(id: 28, todo: "Go to the gym", completed: true, userId: 15);

  test(
    'should add task ',
    () async {
      when(mockTodoRepository.addNewTask(AddTaskParams(
          body: AddTaskParamsBody(
        completed: taskModel.completed,
        todo: taskModel.todo,
        userId: taskModel.userId,
      )))).thenAnswer((_) async => Right(gettaskEntity));
      final result = await usecase(AddTaskParams(
          body: AddTaskParamsBody(
        completed: taskModel.completed,
        todo: taskModel.todo,
        userId: taskModel.userId,
      )));
      expect(result, Right(gettaskEntity));
      verify(mockTodoRepository.addNewTask(AddTaskParams(
          body: AddTaskParamsBody(
        completed: taskModel.completed,
        todo: taskModel.todo,
        userId: taskModel.userId,
      ))));
      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
