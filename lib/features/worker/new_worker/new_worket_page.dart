import 'package:flutter/material.dart';

import '../../../components/dropdown/components/osk_dropdown_menu_item.dart';
import '../../../components/dropdown/osk_multiselect_dropdown.dart';
import '../../../components/osk_button.dart';
import '../../../components/osk_close_icon_button.dart';
import '../../../components/osk_scaffold.dart';
import '../../../components/osk_scaffold_header.dart';
import '../../../components/osk_service_icons.dart';
import '../../../components/osk_text_field.dart';

class NewWorkerPage extends StatefulWidget {
  const NewWorkerPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewWorkerPageState();
}

class _NewWorkerPageState extends State<NewWorkerPage> {
  late final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => focusNode.requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: OskScaffold(
        appBar: AppBar(
          actions: [
            OskCloseIconButton(onClose: () {}), // TODO
            SizedBox(width: 8),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OskScaffoldHeader(
                    icon: OskServiceIcon.worker(),
                    title: 'Новый сотрудник',
                  ),
                  SizedBox(height: 24),
                  OskTextField(
                    label: 'ФИО',
                    hintText: 'Аркадий Аркадий Васильев',
                    focusNode: focusNode,
                  ),
                  SizedBox(height: 16),
                  OskTextField(
                    label: 'Логин',
                    hintText: 'aa_vasilev',
                  ),
                  SizedBox(height: 16),
                  OskTextField(
                    label: 'Пароль',
                    hintText: '******',
                    showobscureTextIcon: true,
                  ),
                  SizedBox(height: 16),
                  // TODO: пока непонятны значения
                  MultiselectDropDown<String>(
                    label: 'Доступные склады',
                    items: [
                      OskDropdownMenuItem(label: 'Склад 1', value: '1'),
                      OskDropdownMenuItem(label: 'Склад 2', value: '2'),
                      OskDropdownMenuItem(label: 'Склад 3', value: '3'),
                    ],
                  ),
                  SizedBox(height: 16),
                  MultiselectDropDown<String>(
                    label: 'Доcтупы',
                    items: [
                      OskDropdownMenuItem(
                        label: 'Удаление пользователей',
                        value: '1',
                      ),
                      OskDropdownMenuItem(
                        label: 'Добавление товаров',
                        value: '2',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: OskButton.main(
              title: 'Добавить',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
