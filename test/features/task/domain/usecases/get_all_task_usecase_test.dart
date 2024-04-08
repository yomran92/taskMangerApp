
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/data/repositories/default_task_repository.dart';
import 'package:todoapp/features/task/domain/entities/get_all_task_entity.dart';
import 'package:todoapp/features/task/domain/usecases/get_all_task_usecase.dart';

class MockTodoRepository extends Mock
    implements DefaultTaskRepository {}

void main() {
  late GetAllTaskUsecase usecase;
 late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetAllTaskUsecase(mockTodoRepository);
  });

  final pgNumber = 1;
  final getAlltaskEntity = GetAllTaskEntity( taskList: []);

  test(
    'should get All TAsk ',
        () async {

      when(mockTodoRepository.getAllTask(GetAllTaskParams(body: GetAllTaskParamsBody(pageNumber: pgNumber))))
          .thenAnswer((_) async => Right(getAlltaskEntity));
       final result = await usecase(GetAllTaskParams(body: GetAllTaskParamsBody(pageNumber: pgNumber)));
       expect(result, Right(getAlltaskEntity));
       verify(mockTodoRepository.getAllTask(GetAllTaskParams(body: GetAllTaskParamsBody(pageNumber: pgNumber))));
       verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}

