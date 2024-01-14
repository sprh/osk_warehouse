import 'package:flutter/material.dart';

import '../../../components/osk_button.dart';
import '../../../components/osk_close_icon_button.dart';
import '../../../components/osk_scaffold.dart';
import '../../../components/osk_service_icons.dart';
import '../../../components/osk_text_field.dart';

class NewWarehousePage extends StatefulWidget {
  const NewWarehousePage({super.key});

  @override
  State<StatefulWidget> createState() => _NewWarehousePageState();
}

class _NewWarehousePageState extends State<NewWarehousePage> {
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
        header: OskScaffoldHeader(
          title: 'Новый склад',
          leading: OskServiceIcon.warehouse(),
          actions: [
            OskCloseIconButton(onClose: () {}),
            SizedBox(width: 8),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24),
            OskTextField(
              label: 'Название',
              hintText: 'Склад 1',
              focusNode: focusNode,
            ),
            SizedBox(height: 16),
            OskTextField(
              label: 'Описание',
              hintText: 'Описание склада',
            ),
          ],
        ),
        actions: [
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
