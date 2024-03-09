import 'package:flutter/material.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/osk_line_divider.dart';
import '../../../../common/components/request_info/request_info_status.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../../../products/components/products_list.dart';
import '../../../products/models/product.dart';
import '../../models/request.dart';

class RequestInfoPage extends StatelessWidget {
  static final products = <Product>[];

  const RequestInfoPage({super.key});

  @override
  Widget build(BuildContext context) => OskScaffold(
        header: OskScaffoldHeader.customTitle(
          leading: const OskServiceIcon.request(),
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OskText.title1(
                text: 'Заявка #121212',
                fontWeight: OskfontWeight.bold,
              ),
              const OskRequestInfoStatus(status: RequestStatus.accepted),
            ],
          ),
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OskText.body(
                text: 'Тип заявки',
                fontWeight: OskfontWeight.bold,
              ),
              OskText.body(text: 'Добавление'),
              const SizedBox(height: 8),
              const OskLineDivider(),
              const SizedBox(height: 8),
              OskText.body(
                text: 'Миша Хромин',
                fontWeight: OskfontWeight.bold,
              ),
              OskText.body(
                text: 'Комментарий',
              ),
              OskText.body(
                text:
                    'Аааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааа',
                colorType: OskTextColorType.minor,
              ),
              const SizedBox(height: 8),
              ProductsList(
                products: products,
                onProductTap: (id) {}, // TODO:
              ),
            ],
          ),
        ),
        actionsDirection: Axis.horizontal,
        actions: [
          OskButton.minor(
            title: 'Отклонить',
            onTap: () {}, // TODO:
          ),
          OskButton.main(
            title: 'Подтвердить',
            onTap: () {}, // TODO:
          ),
        ],
      );
}
