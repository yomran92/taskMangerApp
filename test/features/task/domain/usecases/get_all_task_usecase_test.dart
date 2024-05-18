import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/data/repositories/default_task_repository.dart';
import 'package:todoapp/features/task/domain/entities/get_all_task_entity.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';
import 'package:todoapp/features/task/domain/usecases/get_all_task_usecase.dart';

class MockTodoRepository extends Mock implements DefaultTaskRepository {}

void main() {
  late GetAllTaskUsecase usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetAllTaskUsecase(mockTodoRepository);
  });

  final limit = 7;
  final skip = 7;
  final getAlltaskEntity =
      GetAllTaskEntity(skip: 2, total: 7, limit: 7, todos: [
    GetTaskEntity(id: 28, completed: false, userId: 15, todo: "Go to the gym"),
    GetTaskEntity(
        id: 30, completed: false, userId: 15, todo: "Take cat on a walk"),
    GetTaskEntity(id: 42, completed: false, userId: 15, todo: "Wash car"),
    GetTaskEntity(
        id: 56,
        completed: false,
        userId: 15,
        todo: "Go on a fishing trip with some friends"),
    GetTaskEntity(
        id: 91, completed: false, userId: 15, todo: "Prepare a 72-hour kit"),
    GetTaskEntity(
        id: 126, completed: false, userId: 15, todo: "Take a bubble bath"),
    GetTaskEntity(
        id: 128,
        completed: false,
        userId: 15,
        todo: "Paint the first thing I see"),
  ]);

  test(
    'should get All TAsk ',
    () async {
      when(mockTodoRepository.getAllTask(GetAllTaskParams(
          body: GetAllTaskParamsBody(
        limit: limit,
        skip: skip,
      )))).thenAnswer((_) async => Right(getAlltaskEntity));
      final result = await usecase(GetAllTaskParams(
          body: GetAllTaskParamsBody(
        limit: limit,
        skip: skip,
      )));
      expect(result, Right(getAlltaskEntity));
      verify(mockTodoRepository.getAllTask(GetAllTaskParams(
          body: GetAllTaskParamsBody(
        limit: limit,
        skip: skip,
      ))));
      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
