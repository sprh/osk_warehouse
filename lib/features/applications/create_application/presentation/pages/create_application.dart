part of '../create_appication_page.dart';

class _CreateApplication extends StatefulWidget {
  final void Function(String description) onCreateTap;
  final CreateApplicationApplicationType type;
  final Warehouse? toWarehouse;
  final Warehouse? fromWarehouse;
  final List<OskCreateApplicationProduct> selectedProducts;
  final VoidCallback onBackTap;

  const _CreateApplication({
    required this.onCreateTap,
    required this.type,
    required this.toWarehouse,
    required this.fromWarehouse,
    required this.selectedProducts,
    required this.onBackTap,
  });

  @override
  State<_CreateApplication> createState() => _CreateApplicationState();
}

class _CreateApplicationState extends State<_CreateApplication> {
  String description = '';

  String get _applicationTypeTitle {
    switch (widget.type) {
      case CreateApplicationApplicationType.send:
        return 'Отправка со склада на склад';
      case CreateApplicationApplicationType.recieve:
        if (widget.fromWarehouse != null) {
          return 'Приемка со склада на склад';
        } else {
          return 'Приемка на склад';
        }
      case CreateApplicationApplicationType.defect:
        return 'Браковка товаров';
      case CreateApplicationApplicationType.use:
        return 'Использование';
    }
  }

  String get _fromWarehouseTitle {
    switch (widget.type) {
      case CreateApplicationApplicationType.send:
      case CreateApplicationApplicationType.recieve:
        return 'Со склада';
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        return 'На складе';
    }
  }

  String get _toWarehouseTitle {
    switch (widget.type) {
      case CreateApplicationApplicationType.send:
      case CreateApplicationApplicationType.recieve:
        return 'На склад';
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final toWarehouse = widget.toWarehouse;
    final fromWarehouse = widget.fromWarehouse;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.deferToChild,
      child: OskScaffold.slivers(
        header: OskScaffoldHeader(
          leading: const OskServiceIcon.request(),
          title: 'Предросмотр заявки',
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        actionsDirection: Axis.horizontal,
        actions: [
          OskButton.minor(
            title: 'Назад',
            onTap: () => widget.onBackTap(),
          ),
          OskButton.main(
            title: 'Создать',
            subtitle: description.trim().isEmpty ? 'Заполните описание' : null,
            state: description.trim().isEmpty
                ? OskButtonState.disabled
                : OskButtonState.enabled,
            onTap: () => widget.onCreateTap(description),
          ),
        ],
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OskText.title2(
                    text: 'Тип заявки',
                    fontWeight: OskfontWeight.bold,
                  ),
                  OskText.body(text: _applicationTypeTitle),
                  const SizedBox(height: 8),
                  const OskLineDivider(),
                  const SizedBox(height: 16),
                  OskTextField(
                    hintText: 'Заполните описание',
                    textInputType: TextInputType.multiline,
                    label: 'Описание',
                    initialText: description,
                    onChanged: (text) => setState(() => description = text),
                    constraints: const BoxConstraints(maxHeight: 200),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 16),
                  if (fromWarehouse != null) ...[
                    OskText.title2(
                      text: _fromWarehouseTitle,
                      fontWeight: OskfontWeight.bold,
                    ),
                    OskText.body(text: fromWarehouse.name),
                  ],
                  if (fromWarehouse != null && toWarehouse != null) ...[
                    const SizedBox(height: 8),
                    const Icon(Icons.arrow_downward_rounded),
                    const SizedBox(height: 8),
                  ],
                  if (toWarehouse != null) ...[
                    OskText.title2(
                      text: _toWarehouseTitle,
                      fontWeight: OskfontWeight.bold,
                    ),
                    OskText.body(text: toWarehouse.name),
                  ],
                  const SizedBox(height: 8),
                  const OskLineDivider(),
                  const SizedBox(height: 8),
                  OskText.title2(
                    text: 'Товары в заявке',
                    fontWeight: OskfontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            sliver: SliverList.separated(
              itemCount: widget.selectedProducts.length,
              itemBuilder: (_, index) {
                final product = widget.selectedProducts[index];

                return Center(
                  child: OskInfoSlot(
                    title: product.product.name,
                    onTap: () {},
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OskText.caption(
                          text: product.count.toString(),
                          fontWeight: OskfontWeight.medium,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
            ),
          ),
        ],
      ),
    );
  }
}
