enum Routes {
  // initial,
  welcome,
  login,
  main,
  newWorker,
  newWarehouse,
  workersList,
  warehouseList,
  producsList;

  static String get initialRouteName => Routes.main.name; // TODO: remove
}
