import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';
import 'package:todoapp/features/task/data/repositories/default_task_repository.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';
import 'package:todoapp/features/task/domain/usecases/delete_task_usecase.dart';

class MockTodoRepository extends Mock implements DefaultTaskRepository {}

void main() {
  late DeleteTaskUsecase usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = DeleteTaskUsecase(mockTodoRepository);
  });

  final taskModel =
      TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);
  final gettaskEntity =
      GetTaskEntity(id: 28, todo: "Go to the gym", completed: true, userId: 15);

  test(
    'should delete ',
    () async {
      when(mockTodoRepository.deleteTask(DeleteTaskParams(
              body: DeleteTaskParamsBody(id: taskModel.id ?? 0))))
          .thenAnswer((_) async => Right(gettaskEntity));
      final result = await usecase(
          DeleteTaskParams(body: DeleteTaskParamsBody(id: taskModel.id ?? 0)));
      expect(result, Right(gettaskEntity));
      verify(mockTodoRepository.deleteTask(
          DeleteTaskParams(body: DeleteTaskParamsBody(id: taskModel.id ?? 0))));
      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
