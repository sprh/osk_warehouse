import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';

class WarehouseDataPage extends StatefulWidget {
  const WarehouseDataPage({super.key});

  @override
  State<StatefulWidget> createState() => _WarehouseDataPageState();
}

class _WarehouseDataPageState extends State<WarehouseDataPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => WarehouseDataBloc.of(context).add(
        WarehouseDataBlocInitializeEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WarehouseDataBloc, WarehouseDataState>(
        bloc: WarehouseDataBloc.of(context),
        builder: (context, state) {
          switch (state) {
            case WarehouseDataStateInitial():
              return OskScaffold.slivers(
                header: _WarehouseDataHeader('Загрузка...'),
                slivers: const [
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            case WarehouseDataStateNewWarehouse():
            case WarehouseDataStateUpdateWarehouse():
              return _WarehouseDataPage(state: state);
          }
        },
      );
}

class _WarehouseDataHeader extends OskScaffoldHeader {
  _WarehouseDataHeader(String title)
      : super(
          title: title,
          leading: const OskServiceIcon.warehouse(),
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        );
}

class _WarehouseDataPage extends StatefulWidget {
  final WarehouseDataState state;

  const _WarehouseDataPage({required this.state});

  @override
  State<_WarehouseDataPage> createState() => __WarehouseDataPageState();
}

class __WarehouseDataPageState extends State<_WarehouseDataPage> {
  late String name;
  late String address;

  late final String title;
  late final String buttonTitle;

  bool buttonEnabled = false;

  bool get loading {
    final state = widget.state;

    switch (state) {
      case WarehouseDataStateInitial():
        return false;
      case WarehouseDataStateNewWarehouse():
        return state.loading;
      case WarehouseDataStateUpdateWarehouse():
        return state.loading;
    }
  }

  @override
  void initState() {
    super.initState();
    final state = widget.state;

    switch (state) {
      case WarehouseDataStateInitial():
        throw StateError(
          'Incorrect use of _WarehouseDataPage for initial state',
        );
      case WarehouseDataStateNewWarehouse():
        name = '';
        address = '';
        title = 'Новый склад';
        buttonTitle = 'Добавить';
      case WarehouseDataStateUpdateWarehouse():
        name = state.name;
        address = state.address;
        title = 'Редактирование склада';
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
                hintText: 'Склад 1',
                initialText: name,
                onChanged: (text) {
                  name = text;
                  _onTextChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Адрес',
                hintText: 'Адрес склада',
                initialText: address,
                onChanged: (text) {
                  address = text;
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
              onTap: () => WarehouseDataBloc.of(context).add(
                WarehouseDataBlocCreateOrUpdateEvent(
                  name: name,
                  address: address,
                ),
              ),
            ),
          ],
        ),
      );

  void _onTextChanged() {
    final name = this.name;
    final address = this.address;

    bool dataChanged(WarehouseDataState state) {
      switch (state) {
        case WarehouseDataStateInitial():
        case WarehouseDataStateNewWarehouse():
          return true;
        case WarehouseDataStateUpdateWarehouse():
          return state.name != name || state.address != address;
      }
    }

    buttonEnabled = name.isNotEmpty &&
        address.isNotEmpty &&
        dataChanged(
          widget.state,
        );

    setState(() {});
  }
}
