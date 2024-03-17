part of 'bloc.dart';

sealed class ApplicationDataState {}

class ApplicationDataStateIdle implements ApplicationDataState {}

class ApplicationDataStateData implements ApplicationDataState {
  final Application application;
  final bool loading;

  const ApplicationDataStateData(this.application, {this.loading = false});

  ApplicationDataStateData copyWith({
    Application? application,
    bool? loading,
  }) =>
      ApplicationDataStateData(
        application ?? this.application,
        loading: loading ?? this.loading,
      );
}
