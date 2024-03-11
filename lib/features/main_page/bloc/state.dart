sealed class MainPageState {}

class MainPageStateIdle implements MainPageState {}

class MainPageStateData implements MainPageState {
  final Set<MainPageBlocks> availableBlocks;
  final String userName;

  const MainPageStateData({
    required this.availableBlocks,
    required this.userName,
  });
}

enum MainPageBlocks {
  createRequest,
  requests,
  warehouses,
  workers,
  reports,
  products,
}
