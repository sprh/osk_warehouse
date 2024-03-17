part of '../create_appication_page.dart';

class _CreateApplication extends StatefulWidget {
  final void Function(String description) onCreateTap;
  final ApplicationType type;
  final Warehouse firstWarehouse;
  final Warehouse? secondWarehouse;
  final List<OskCreateApplicationProduct> selectedProducts;

  const _CreateApplication({
    required this.onCreateTap,
    required this.type,
    required this.firstWarehouse,
    required this.secondWarehouse,
    required this.selectedProducts,
  });

  @override
  State<_CreateApplication> createState() => _CreateApplicationState();
}

class _CreateApplicationState extends State<_CreateApplication> {
  String description = '';

  String get _applicationTypeTitle {
    switch (widget.type) {
      case ApplicationType.send:
        return 'Отправка со склада на склад';
      case ApplicationType.recieve:
        if (widget.secondWarehouse != null) {
          return 'Приемка со склада на склад';
        } else {
          return 'Приемка на склад';
        }
      case ApplicationType.defect:
        return 'Браковка товаров';
      case ApplicationType.use:
        return 'Использование';
      case ApplicationType.revert:
        return 'Отмена заявки';
    }
  }

  String get _firstWarehouseTitle {
    switch (widget.type) {
      case ApplicationType.send:
        return 'Со склада';
      case ApplicationType.recieve:
        if (widget.secondWarehouse != null) {
          return 'Со склада';
        } else {
          return 'На склад';
        }
      case ApplicationType.defect:
      case ApplicationType.use:
        return 'На складе';
      case ApplicationType.revert:
        return '';
    }
  }

  String get _secondWarehouseTitle {
    switch (widget.type) {
      case ApplicationType.send:
        return 'На склад';
      case ApplicationType.recieve:
        return 'На склад';
      case ApplicationType.defect:
      case ApplicationType.use:
      case ApplicationType.revert:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
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
          actions: [
            OskButton.main(
              title: 'Создать',
              subtitle:
                  description.trim().isEmpty ? 'Заполните описание' : null,
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
                    OskText.title2(
                      text: _firstWarehouseTitle,
                      fontWeight: OskfontWeight.bold,
                    ),
                    OskText.body(text: widget.firstWarehouse.name),
                    if (widget.secondWarehouse != null) ...[
                      const SizedBox(height: 8),
                      const Icon(Icons.arrow_downward_rounded),
                      const SizedBox(height: 16),
                      OskText.title2(
                        text: _secondWarehouseTitle,
                        fontWeight: OskfontWeight.bold,
                      ),
                      OskText.body(text: widget.secondWarehouse!.name),
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
              padding: const EdgeInsets.only(top: 8),
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
