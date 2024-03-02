import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text_field.dart';
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
  late String name;

  late final String title;
  late final String buttonTitle;

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
        name = '';
        title = 'Новый продукт';
        buttonTitle = 'Добавить';
      case ProductDataStateUpdate():
        name = state.product.name;
        title = 'Редактирование продукта';
        buttonTitle = 'Обновить';
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusScope.of(context).requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
                hintText: 'Продукт 1',
                initialText: name,
                onChanged: (text) {
                  name = text;
                  _onTextChanged();
                },
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
                  codes: [], // TODO:
                ),
              ),
            ),
          ],
        ),
      );

  void _onTextChanged() {
    final name = this.name;

    bool dataChanged(ProductDataState state) {
      switch (state) {
        case ProductDataStateInitial():
          return true;
        case ProductDataStateCreate():
          return true;
        case ProductDataStateUpdate():
          return state.product.name != name;
      }
    }

    buttonEnabled = name.isNotEmpty &&
        dataChanged(
          widget.state,
        );

    setState(() {});
  }
}
