import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/dropdown/components/osk_dropdown_menu_item.dart';
import '../../../../common/components/dropdown/osk_multiselect_dropdown.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../models/user_access_types.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => UserDataBloc.of(context).add(
        UserDataPageEventInitialize(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserDataBloc, UserDataState>(
        bloc: UserDataBloc.of(context),
        builder: (context, state) {
          switch (state) {
            case UserDataStateInitial():
              return OskScaffold.slivers(
                header: _UserDataHeader('Загрузка...'),
                slivers: const [
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            case UserDataStateUpdate():
            case UserDataStateCreate():
              return _UserDataPage(state: state);
          }
        },
      );
}

class _UserDataHeader extends OskScaffoldHeader {
  _UserDataHeader(String title)
      : super(
          title: title,
          leading: const OskServiceIcon.warehouse(),
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        );
}

class _UserDataPage extends StatefulWidget {
  final UserDataState state;

  const _UserDataPage({required this.state});

  @override
  State<_UserDataPage> createState() => __UserDataPageState();
}

class __UserDataPageState extends State<_UserDataPage> {
  late String username;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late Set<Warehouse> warehouses;
  late Set<UserAccessTypes> accessTypes;
  String password = '';

  late List<Warehouse> availableWarehouses;

  late final String title;
  late final String buttonTitle;

  bool buttonEnabled = false;
  bool canEditUsername = true;

  bool get loading {
    final state = widget.state;

    switch (state) {
      case UserDataStateInitial():
        return true;
      case UserDataStateUpdate():
        return state.loading;
      case UserDataStateCreate():
        return state.loading;
    }
  }

  @override
  void initState() {
    super.initState();
    final state = widget.state;

    switch (state) {
      case UserDataStateInitial():
        throw StateError(
          'Incorrect use of _UserDataPage for initial state',
        );
      case UserDataStateUpdate():
        username = state.user.username;
        firstName = state.user.firstName;
        lastName = state.user.lastName;
        phoneNumber = state.user.phoneNumber;
        warehouses = state.user.warehouses
            .map(
              (id) => state.availableWarehouses.firstWhereOrNull(
                (warehouse) => warehouse.id == id,
              ),
            )
            .whereNotNull()
            .toSet();
        accessTypes = state.user.accesses;
        title = 'Редактирование пользователя';
        buttonTitle = 'Обновить';
        availableWarehouses = state.availableWarehouses;
        canEditUsername = false;
      case UserDataStateCreate():
        username = '';
        firstName = '';
        lastName = '';
        phoneNumber = '';
        warehouses = {};
        accessTypes = {};
        title = 'Новый пользователь';
        buttonTitle = 'Добавить';
        availableWarehouses = state.availableWarehouses;
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
                label: 'Имя пользователя',
                hintText: 'vasya123',
                initialText: username,
                readOnly: !canEditUsername,
                onChanged: (text) {
                  username = text;
                  _onTextChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Имя',
                hintText: 'Вася',
                initialText: firstName,
                onChanged: (text) {
                  firstName = text;
                  _onTextChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Фамилия',
                hintText: 'Пупкин',
                initialText: lastName,
                onChanged: (text) {
                  lastName = text;
                  _onTextChanged();
                },
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Телефон',
                hintText: '+70000000000',
                initialText: phoneNumber,
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[+0-9]')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  phoneNumber = text;
                  _onTextChanged();
                },
              ),
              const SizedBox(height: 16),
              OskMultiSelectDropDown<Warehouse>(
                label: 'Доступные склады',
                items: availableWarehouses
                    .map(
                      (warehouse) => OskDropdownMenuItem(
                        label: warehouse.name,
                        details: warehouse.address,
                        value: warehouse,
                      ),
                    )
                    .toList(),
                onSelectedItemsChanged: (items) {
                  warehouses = items;
                  _onTextChanged();
                },
                initialSelectedValues: warehouses.toSet(),
              ),
              const SizedBox(height: 16),
              OskMultiSelectDropDown<UserAccessTypes>(
                label: 'Доcтупы',
                items: [
                  OskDropdownMenuItem(
                    label: 'Админ',
                    value: UserAccessTypes.admin,
                  ),
                  OskDropdownMenuItem(
                    label: 'Ревьюер',
                    value: UserAccessTypes.reviewer,
                  ),
                  OskDropdownMenuItem(
                    label: 'Суперюзер',
                    value: UserAccessTypes.superuser,
                  ),
                ],
                initialSelectedValues: accessTypes,
              ),
              const SizedBox(height: 16),
              OskTextField(
                label: 'Пароль',
                hintText: '1234567890',
                onChanged: (text) {
                  password = text;
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
              onTap: () {}, // TODO:
            ),
          ],
        ),
      );

  void _onTextChanged() {
    final state = widget.state;

    buttonEnabled = () {
      final isNotEmpty = username.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          phoneNumber.isNotEmpty;

      switch (state) {
        case UserDataStateInitial():
        case UserDataStateCreate():
          return isNotEmpty && password.isNotEmpty;
        case UserDataStateUpdate():
          final dataUpdated = username != state.user.username ||
              firstName != state.user.firstName ||
              lastName != state.user.lastName ||
              phoneNumber != state.user.phoneNumber;
          final warehousesUpdated = setEquals(
            warehouses.map((w) => w.id).toSet(),
            state.user.warehouses.toSet(),
          );
          final accessesUpdated = setEquals(
            accessTypes,
            state.user.accesses,
          );
          return isNotEmpty &&
              (dataUpdated ||
                  warehousesUpdated ||
                  accessesUpdated ||
                  password.isNotEmpty);
      }
    }.call();

    setState(() {});
  }
}
