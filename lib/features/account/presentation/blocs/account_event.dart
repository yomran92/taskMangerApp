part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class LogInEvent extends AccountEvent {
  final LogInParams? logInParams;

  LogInEvent({this.logInParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
