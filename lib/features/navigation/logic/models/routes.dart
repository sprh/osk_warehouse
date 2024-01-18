enum Routes {
  // initial,
  welcome,
  login,
  main,
  newWorker,
  newWarehouse,
  workersList,
  warehouseList,
  producsList,
  requestsList,
  requestInfo;

  static String get initialRouteName => Routes.main.name; // TODO: remove
}
