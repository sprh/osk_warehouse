enum Routes {
  // initial,
  welcome,
  login,
  main,
  newWorker,
  newWarehouse,
  workersList;

  static String get initialRouteName => Routes.workersList.name; // TODO: remove
}
