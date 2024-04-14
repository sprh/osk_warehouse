part of '../create_appication_page.dart';

class _CreateApplicationScreenWarehouse extends StatefulWidget {
  final void Function(Warehouse?) onWarehouseSelected;
  final List<Warehouse> availableWarehouses;
  final bool canSkipStep;
  final String title;
  final VoidCallback? onBackButtonTap;
  final String? selectedWarehouseId;

  const _CreateApplicationScreenWarehouse({
    required this.onWarehouseSelected,
    required this.availableWarehouses,
    required this.canSkipStep,
    required this.title,
    required this.onBackButtonTap,
    required this.selectedWarehouseId,
  });

  @override
  State<_CreateApplicationScreenWarehouse> createState() =>
      _CreateApplicationScreenWarehouseState();
}

class _CreateApplicationScreenWarehouseState
    extends State<_CreateApplicationScreenWarehouse> {
  late Warehouse? selected = widget.availableWarehouses.firstWhereOrNull(
    (warehouse) => warehouse.id == widget.selectedWarehouseId,
  );

  @override
  void didUpdateWidget(covariant _CreateApplicationScreenWarehouse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.availableWarehouses != oldWidget.availableWarehouses ||
        widget.selectedWarehouseId != oldWidget.selectedWarehouseId) {
      selected = widget.availableWarehouses.firstWhereOrNull(
        (warehouse) => warehouse.id == widget.selectedWarehouseId,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => OskScaffold.slivers(
        header: OskScaffoldHeader(
          leading: const OskServiceIcon.request(),
          title: widget.title,
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        actionsDirection: Axis.horizontal,
        actions: [
          if (widget.onBackButtonTap != null)
            OskButton.minor(
              title: 'Назад',
              onTap: widget.onBackButtonTap!,
            ),
          OskButton.main(
            title: 'Далее',
            subtitle: widget.canSkipStep ? '(необязательно)' : null,
            state: selected == null && !widget.canSkipStep
                ? OskButtonState.disabled
                : OskButtonState.enabled,
            onTap: () {
              if (selected != null || widget.canSkipStep) {
                widget.onWarehouseSelected(selected);
              }
            },
          ),
        ],
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 32),
            sliver: SliverList.separated(
              itemBuilder: (_, index) {
                final current = widget.availableWarehouses[index];

                return Center(
                  child: OskInfoSlot(
                    selected: selected?.id == current.id,
                    onSelected: () => _onSelect(current),
                    title: current.name,
                    onTap: () => _onSelect(current),
                  ),
                );
              },
              itemCount: widget.availableWarehouses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
            ),
          ),
        ],
      );

  void _onSelect(Warehouse warehouse) {
    if (warehouse.id == selected?.id) {
      setState(() => selected = null);
    } else {
      setState(() => selected = warehouse);
    }
  }
}
