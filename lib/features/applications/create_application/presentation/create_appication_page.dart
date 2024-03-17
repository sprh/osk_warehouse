import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/info_slot/osk_info_slot.dart';
import '../../../../common/components/osk_line_divider.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../../../../utils/kotlin_utils.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../models/application/appication_type.dart';
import '../../models/osk_create_application_product.dart';
import '../bloc/bloc.dart';
import 'components/application_type.dart';

part 'pages/create_application.dart';
part 'pages/select_products.dart';
part 'pages/select_type.dart';
part 'pages/select_warehouse.dart';

class CreateApplicationPage extends StatefulWidget {
  const CreateApplicationPage({super.key});

  @override
  State<CreateApplicationPage> createState() => _CreateApplicationPageState();
}

class _CreateApplicationPageState extends State<CreateApplicationPage> {
  ApplicationType? applicationType;
  String? description;

  Warehouse? firstSelectedWarehouse;
  Warehouse? secondSelectedWarehouse;

  bool get needSelectSecondWarehouse {
    switch (applicationType) {
      case ApplicationType.send:
      case ApplicationType.recieve:
        return true;
      case ApplicationType.defect:
      case ApplicationType.use:
      case ApplicationType.revert:
      case null:
        return false;
    }
  }

  bool get selectSecondWarehouseIsNecessary {
    switch (applicationType) {
      case ApplicationType.send:
        return true;
      case ApplicationType.recieve:
      case ApplicationType.defect:
      case ApplicationType.use:
      case ApplicationType.revert:
      case null:
        return false;
    }
  }

  String get selectToWarehouseTitle {
    switch (applicationType) {
      case null:
        return '';
      case ApplicationType.send:
        return 'Выберите склад, на который отправится товар';
      case ApplicationType.recieve:
        return 'Выберите склад приемки';
      case ApplicationType.defect:
        return 'Выберите склад';
      case ApplicationType.use:
        return 'Выберите склад';
      case ApplicationType.revert:
        return '';
    }
  }

  String get selectFromWarehouseTitle {
    switch (applicationType) {
      case null:
        return '';
      case ApplicationType.send:
        return 'Выберите склад, с которого отправится товар';
      case ApplicationType.recieve:
        return 'Выберите склад, с которого отправится товар (необязательно)';
      case ApplicationType.defect:
      case ApplicationType.use:
      case ApplicationType.revert:
        return '';
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => CreateApplicationBloc.of(context).add(
        CreateApplicationEventInitialize(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateApplicationBloc, CreateApplicationState>(
        bloc: CreateApplicationBloc.of(context),
        builder: (context, state) {
          switch (state) {
            case CreateApplicationStateIdle():
              return OskScaffold.slivers(
                header: OskScaffoldHeader(
                  leading: const OskServiceIcon.request(),
                  title: 'Создание заявки',
                  actions: const [
                    OskCloseIconButton(),
                    SizedBox(width: 8),
                  ],
                ),
                slivers: const [
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            case CreateApplicationStateSelectType():
              return _CreateApplicationScreenType(
                onTypeSelected: (type) => CreateApplicationBloc.of(context).add(
                  CreateApplicationEventOnTypeSelected(type),
                ),
              );
            case CreateApplicationStateSelectToWarehouse():
              return _CreateApplicationScreenWarehouse(
                availableWarehouses: state.availableWarehouses,
                title: selectToWarehouseTitle,
                onWarehouseSelected: (warehose) {
                  if (warehose != null) {
                    CreateApplicationBloc.of(context).add(
                      CreateApplicationEventOnToWarehouseSelected(warehose),
                    );
                  }
                },
                canSkipStep: false,
              );
            case CreateApplicationStateSelectFromWarehouse():
              return _CreateApplicationScreenWarehouse(
                availableWarehouses: state.availableWarehouses
                    .where((w) => w.id != state.toWarehouse.id)
                    .toList(),
                title: selectFromWarehouseTitle,
                onWarehouseSelected: (warehose) =>
                    CreateApplicationBloc.of(context).add(
                  CreateApplicationEventOnFromWarehouseSelected(warehose),
                ),
                canSkipStep: state.canBeSkipped,
              );
            case CreateApplicationStateSelectProducts():
              return _SelectProducts(
                products: state.selectedProducts,
                onAddProductsTap: () => CreateApplicationBloc.of(context).add(
                  CreateApplicationEventSelectProductsButtonTap(),
                ),
                onNextTap: () => CreateApplicationBloc.of(context).add(
                  CreateApplicationEventOnShowFinalScreen(),
                ),
                onRemove: (id) => CreateApplicationBloc.of(context).add(
                  CreateApplicationEventRemoveProduct(id),
                ),
                onChangeCount: (id, count) =>
                    CreateApplicationBloc.of(context).add(
                  CreateApplicationEventChangeCount(id, count),
                ),
              );
            case CreateApplicationStateFinal():
              return _CreateApplication(
                type: state.type,
                onCreateTap: (description) =>
                    CreateApplicationBloc.of(context).add(
                  CreateApplicationCreateButtonTap(description),
                ),
                firstWarehouse: state.toWarehouse,
                secondWarehouse: state.fromWarehouse,
                selectedProducts: state.selectedProducts,
              );
          }
        },
      );
}
