import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_icons.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../../../../common/theme/utils/theme_from_context.dart';
import '../../../category/presentation/categories_list_dropdown_item.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';

class ProductDataPage extends StatefulWidget {
  const ProductDataPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProductDataPageState();
}

class _ProductDataPageState extends State<ProductDataPage> {
  late final bloc = ProductDataBloc.of(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => bloc.add(
        ProductDataPageEventInitialize(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDataBloc, ProductDataState>(
        bloc: ProductDataBloc.of(context),
        builder: (context, state) {
          switch (state) {
            case ProductDataStateInitial():
              return OskScaffold.slivers(
                header: _ProductDataHeader('Загрузка...'),
                slivers: const [
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            case ProductDataStateUpdate():
            case ProductDataStateCreate():
              return _ProductDataPage(state: state);
          }
        },
      );

  @override
  void dispose() {
    bloc.stop();
    super.dispose();
  }
}

class _ProductDataHeader extends OskScaffoldHeader {
  _ProductDataHeader(String title)
      : super(
          title: title,
          leading: const OskServiceIcon.warehouse(),
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        );
}

class _ProductDataPage extends StatefulWidget {
  final ProductDataState state;

  const _ProductDataPage({required this.state});

  @override
  State<_ProductDataPage> createState() => __ProductDataPageState();
}

class __ProductDataPageState extends State<_ProductDataPage> {
  late String title;
  late String? buttonTitle;

  String? category;
  late String manufacturer;
  late String model;
  String? description;

  Map<String, int>? warehouseCount;

  late TextEditingController nameTextEditingController = TextEditingController(
    text: name,
  );

  bool buttonEnabled = false;

  bool get loading {
    final state = widget.state;

    switch (state) {
      case ProductDataStateInitial():
        return false;
      case ProductDataStateUpdate():
        return state.loading;
      case ProductDataStateCreate():
        return state.loading;
    }
  }

  Set<String> get barcodes {
    final state = widget.state;

    switch (state) {
      case ProductDataStateInitial():
        return {};
      case ProductDataStateUpdate():
        return state.barcodes;
      case ProductDataStateCreate():
        return state.barcodes;
    }
  }

  String get name =>
      manufacturer.isEmpty || model.isEmpty ? '' : '$manufacturer - $model';

  bool get canUpdate {
    final state = widget.state;
    switch (state) {
      case ProductDataStateInitial():
        return false;
      case ProductDataStateUpdate():
        return state.showUpdateProductButton;
      case ProductDataStateCreate():
        return state.showUpdateProductButton;
    }
  }

  @override
  void didUpdateWidget(covariant _ProductDataPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _onDataChanged();
  }

  @override
  void initState() {
    super.initState();
    final state = widget.state;

    switch (state) {
      case ProductDataStateInitial():
        throw StateError(
          'Incorrect use of _ProductDataPage for initial state',
        );
      case ProductDataStateCreate():
        title = 'Новый продукт';
        buttonTitle = 'Добавить';
        manufacturer = '';
        model = '';
      case ProductDataStateUpdate():
        if (state.showUpdateProductButton) {
          title = 'Редактирование продукта';
          buttonTitle = 'Обновить';
        } else {
          title = 'О продукте';
          buttonTitle = null;
        }
        manufacturer = state.product.manufacturer;
        model = state.product.model;
        description = state.product.description;
        warehouseCount = state.product.warehouseCount;
        category = state.product.type;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusScope.of(context).requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: OskScaffold(
          header: OskScaffoldHeader(
            title: title,
            leading: const OskServiceIcon.warehouse(),
            actions: const [
              OskCloseIconButton(),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              OskTextField(
                label: 'Название',
                hintText: 'Подставится автоматически',
                textEditingController: nameTextEditingController,
                readOnly: true,
              ),
              const SizedBox(height: 16),
              IgnorePointer(
                ignoring: !canUpdate,
                child: CategoriesListDropdownItem(
                  selectedCategory: category,
                  canAddCategory: canUpdate,
                  onSelectedCategoryChanged: (value) {
                    category = value;
                    _onDataChanged();
                  },
                ),
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Производитель',
                hintText: 'Автора',
                readOnly: !canUpdate,
                initialText: manufacturer,
                onChanged: (manufacturer) {
                  this.manufacturer = manufacturer;
                  _onDataChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Модель',
                hintText: 'Картридж',
                readOnly: !canUpdate,
                initialText: model,
                onChanged: (model) {
                  this.model = model;
                  _onDataChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Описание',
                hintText: 'Заполнять необязательно',
                readOnly: !canUpdate,
                initialText: description,
                onChanged: (description) {
                  this.description = description;
                  _onDataChanged();
                },
              ),
              const SizedBox(height: 16),
              IgnorePointer(
                ignoring: !canUpdate,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _BarcodesListWidget(
                    barcodes: barcodes,
                    onAddBarcodeTap: () => ProductDataBloc.of(context).add(
                      ProductDataPageEventScanBarcode(),
                    ),
                    onDeleteBarcodeTap: (id) => ProductDataBloc.of(context).add(
                      ProductDataPageEventDeleteBarcode(id: id),
                    ),
                    canEdit: canUpdate,
                  ),
                ),
              ),
              if (warehouseCount != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OskText.title2(
                    text: 'Количество продукта на складах',
                    fontWeight: OskfontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Table(
                    border: const TableBorder.symmetric(
                      inside: BorderSide(),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      for (final data in warehouseCount!.entries)
                        TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: Align(
                                  child: OskText.body(
                                    text: data.key,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: Align(
                                  child: OskText.body(
                                    text: data.value.toString(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
          actions: [
            if (canUpdate && buttonTitle != null)
              OskButton.main(
                title: buttonTitle!,
                state: loading
                    ? OskButtonState.loading
                    : buttonEnabled
                        ? OskButtonState.enabled
                        : OskButtonState.disabled,
                onTap: () => ProductDataBloc.of(context).add(
                  ProductDataPageEventAddOrUpdateProduct(
                    name: name,
                    codes: barcodes,
                    itemType: category,
                    manufacturer: manufacturer,
                    model: model,
                    description: description,
                  ),
                ),
              ),
          ],
        ),
      );

  void _onDataChanged() {
    final name = this.name;

    bool dataChanged(ProductDataState state) {
      switch (state) {
        case ProductDataStateInitial():
          return true;
        case ProductDataStateCreate():
          return true;
        case ProductDataStateUpdate():
          return state.product.manufacturer != manufacturer ||
              state.product.type != category ||
              state.product.model != model ||
              state.product.description != description ||
              state.product.codes != state.barcodes;
      }
    }

    buttonEnabled = name.isNotEmpty && dataChanged(widget.state);
    nameTextEditingController.text = name;

    setState(() {});
  }
}

class _BarcodesListWidget extends StatelessWidget {
  final Set<String> barcodes;
  final VoidCallback onAddBarcodeTap;
  final void Function(String) onDeleteBarcodeTap;
  final bool canEdit;

  const _BarcodesListWidget({
    required this.barcodes,
    required this.onAddBarcodeTap,
    required this.onDeleteBarcodeTap,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final barcode in barcodes)
            _BarcodeItem(
              barcode: barcode,
              onDeleteBarcodeTap: onDeleteBarcodeTap,
              canEdit: canEdit,
            ),
          if (canEdit)
            InkWell(
              onTap: onAddBarcodeTap,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.textFiledTheme.outlineColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.add,
                    color: context.textFiledTheme.outlineColor,
                  ),
                ),
              ),
            ),
        ],
      );
}

class _BarcodeItem extends StatelessWidget {
  final String barcode;
  final void Function(String) onDeleteBarcodeTap;
  final bool canEdit;

  const _BarcodeItem({
    required this.barcode,
    required this.onDeleteBarcodeTap,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.textFiledTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.outlineColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          OskText.body(text: barcode),
          const SizedBox(width: 8),
          if (canEdit)
            InkWell(
              onTap: () => onDeleteBarcodeTap(barcode),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: OskIcon.delete(),
              ),
            ),
        ],
      ),
    );
  }
}
