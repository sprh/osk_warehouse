import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../new_warehouse_bloc/new_warehouse_bloc.dart';

class NewWarehousePage extends StatefulWidget {
  const NewWarehousePage({super.key});

  @override
  State<StatefulWidget> createState() => _NewWarehousePageState();
}

class _NewWarehousePageState extends State<NewWarehousePage> {
  String name = '';
  String address = '';

  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusScope.of(context).requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<NewWarehouseBloc, bool>(
        bloc: NewWarehouseBloc.of(context),
        builder: (context, loading) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: OskScaffold(
            header: OskScaffoldHeader(
              title: 'Новый склад',
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
                  onChanged: (text) {
                    name = text;
                    _onTextChanged();
                  },
                ),
                const SizedBox(height: 16),
                OskTextField(
                  label: 'Адрес',
                  hintText: 'Адрес склада',
                  onChanged: (text) {
                    address = text;
                    _onTextChanged();
                  },
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OskButton.main(
                  title: 'Добавить',
                  state: loading
                      ? OskButtonState.loading
                      : buttonEnabled
                          ? OskButtonState.enabled
                          : OskButtonState.disabled,
                  onTap: () => NewWarehouseBloc.of(context).add(
                    NewWarehouseBlocCreateEvent(
                      name: name,
                      address: address,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _onTextChanged() {
    buttonEnabled = name.isNotEmpty && address.isNotEmpty;
    setState(() {});
  }
}
