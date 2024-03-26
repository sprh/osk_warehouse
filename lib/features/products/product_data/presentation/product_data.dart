import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/dropdown/components/osk_dropdown_menu_item.dart';
import '../../../../common/components/dropdown/osk_dropdown_menu.dart';
import '../../../../common/components/icon/osk_icons.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../../../../theme/utils/theme_from_context.dart';
import '../../models/product.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';

class ProductDataPage extends StatefulWidget {
  const ProductDataPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProductDataPageState();
}

class _ProductDataPageState extends State<ProductDataPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ProductDataBloc.of(context).add(
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
  late final String title;
  late final String buttonTitle;

  ProductType? itemType;
  late String manufacturer;
  late String model;
  String? description;

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
        title = 'Редактирование продукта';
        buttonTitle = 'Обновить';
        manufacturer = state.product.manufacturer;
        model = state.product.model;
        description = state.product.description;
        itemType = ProductType.other;
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
              SizedBox(width: 8),
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
              OskDropDown<ProductType>(
                items: [
                  OskDropdownMenuItem(
                    label: 'Другое',
                    value: ProductType.other,
                  ),
                ],
                selectedValuel: itemType,
                label: 'Тип товара',
                onSelectedItemChanged: (type) {
                  itemType = type;
                  _onDataChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Производитель',
                hintText: 'Автора',
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
                initialText: description,
                onChanged: (description) {
                  this.description = description;
                  _onDataChanged();
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _BarcodesListWidget(
                  barcodes: barcodes,
                  onAddBarcodeTap: () => ProductDataBloc.of(context).add(
                    ProductDataPageEventScanBarcode(),
                  ),
                  onDeleteBarcodeTap: (id) => ProductDataBloc.of(context).add(
                    ProductDataPageEventDeleteBarcode(id: id),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            OskButton.main(
              title: buttonTitle,
              state: loading
                  ? OskButtonState.loading
                  : buttonEnabled
                      ? OskButtonState.enabled
                      : OskButtonState.disabled,
              onTap: () => ProductDataBloc.of(context).add(
                ProductDataPageEventAddOrUpdateProduct(
                  name: name,
                  codes: barcodes,
                  itemType: itemType,
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
              state.product.type != itemType ||
              state.product.model != model ||
              state.product.description != description ||
              state.product.codes != barcodes;
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

  const _BarcodesListWidget({
    required this.barcodes,
    required this.onAddBarcodeTap,
    required this.onDeleteBarcodeTap,
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
            ),
          InkWell(
            onTap: onAddBarcodeTap,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.textFiledTheme.outlineColor,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      );
}

class _BarcodeItem extends StatelessWidget {
  final String barcode;
  final void Function(String) onDeleteBarcodeTap;

  const _BarcodeItem({required this.barcode, required this.onDeleteBarcodeTap});

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
