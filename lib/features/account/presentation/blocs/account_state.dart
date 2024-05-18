part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

class LogInLoaded extends AccountState {
  final LogInEntity? logInEntity;

  LogInLoaded({this.logInEntity});

  @override
  List<Object> get props => [];
}

class AccountError extends AccountState {
  final String? message;

  AccountError(this.message);

  @override
  List<Object?> get props => [];
}
