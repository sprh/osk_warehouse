part of '../create_appication_page.dart';

class _CreateApplication extends StatefulWidget {
  final VoidCallback onCreateTap;
  final CreateApplicationStateData state;
  final VoidCallback onBackTap;
  final void Function(String) saveDescription;
  final VoidCallback onEditProducts;

  const _CreateApplication({
    required this.onCreateTap,
    required this.state,
    required this.onBackTap,
    required this.saveDescription,
    required this.onEditProducts,
  });

  @override
  State<_CreateApplication> createState() => _CreateApplicationState();
}

class _CreateApplicationState extends State<_CreateApplication> {
  String get _applicationTypeTitle {
    switch (widget.state.type!) {
      case CreateApplicationApplicationType.send:
        return 'Отправка со склада на склад';
      case CreateApplicationApplicationType.recieve:
        if (widget.state.fromWarehouse != null) {
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
    switch (widget.state.type!) {
      case CreateApplicationApplicationType.send:
      case CreateApplicationApplicationType.recieve:
        return 'Со склада';
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        return 'На складе';
    }
  }

  String get _toWarehouseTitle {
    switch (widget.state.type!) {
      case CreateApplicationApplicationType.send:
      case CreateApplicationApplicationType.recieve:
        return 'На склад';
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        return '';
    }
  }

  String get _title {
    final mode = widget.state.mode;
    switch (mode) {
      case CreateApplicationModeCreate():
        return 'Предпросмотр заявки';
      case CreateApplicationModeEdit():
        return 'Редактирование заявки #${mode.application.id}';
    }
  }

  String get _buttonTitle {
    final mode = widget.state.mode;

    switch (mode) {
      case CreateApplicationModeCreate():
        return 'Создать';
      case CreateApplicationModeEdit():
        return 'Сохранить';
    }
  }

  @override
  Widget build(BuildContext context) {
    final toWarehouse = widget.state.toWarehouse;
    final fromWarehouse = widget.state.fromWarehouse;
    final description = widget.state.description?.trim() ?? '';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.deferToChild,
      child: OskScaffold.slivers(
        header: OskScaffoldHeader(
          leading: const OskServiceIcon.request(),
          title: _title,
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        actionsDirection: Axis.horizontal,
        actions: [
          if (widget.state.mode is! CreateApplicationModeEdit)
            OskButton.minor(
              title: 'Назад',
              onTap: () => widget.onBackTap(),
            ),
          OskButton.main(
            title: _buttonTitle,
            subtitle: description.isEmpty ? 'Заполните описание' : null,
            state: description.isEmpty
                ? OskButtonState.disabled
                : OskButtonState.enabled,
            onTap: widget.onCreateTap,
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
                    onChanged: widget.saveDescription,
                    constraints: const BoxConstraints(maxHeight: 200),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 16),
                  if (fromWarehouse != null)
                    _WarehouseData(
                      title: _fromWarehouseTitle,
                      name: fromWarehouse.name,
                    ),
                  if (fromWarehouse != null && toWarehouse != null) ...[
                    const SizedBox(height: 8),
                    const Icon(Icons.arrow_downward_rounded),
                    const SizedBox(height: 8),
                  ],
                  if (toWarehouse != null)
                    _WarehouseData(
                      title: _toWarehouseTitle,
                      name: toWarehouse.name,
                    ),
                  const SizedBox(height: 8),
                  const OskLineDivider(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OskText.title2(
                        text: 'Товары в заявке',
                        fontWeight: OskfontWeight.bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: widget.onEditProducts,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            sliver: SliverList.separated(
              itemCount: widget.state.selectedProducts!.length,
              itemBuilder: (_, index) {
                final product = widget.state.selectedProducts![index];

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

class _WarehouseData extends StatelessWidget {
  final String title;
  final String name;

  const _WarehouseData({
    required this.title,
    required this.name,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OskText.title2(
            text: title,
            fontWeight: OskfontWeight.bold,
          ),
          OskText.body(text: name),
        ],
      );
}
