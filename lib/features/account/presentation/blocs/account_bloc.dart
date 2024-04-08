import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../service_locator.dart';
import '../../../task/presentation/bloc/task_bloc.dart';
import '../../data/remote/models/params/login_params.dart';
import '../../data/repositories/account_repository.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'account_event.dart';part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(AccountLoading());

      var res =
          await LogInUseCase(sl<AccountRepository>()).call(
              event.logInParams!);
      emit(res.fold((l) =>

          AccountError(_mapFailureToMessage(l)),
          (r) => LogInLoaded(logInEntity: r)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
