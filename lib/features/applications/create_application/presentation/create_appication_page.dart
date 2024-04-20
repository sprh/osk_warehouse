import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/actions/actions_flex.dart';
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
import '../../models/create_application/create_application_application_type.dart';
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
  String? description;

  String _selectToWarehouseTitle(CreateApplicationApplicationType type) {
    switch (type) {
      case CreateApplicationApplicationType.send:
      case CreateApplicationApplicationType.recieve:
        return 'Выберите склад получения';
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        return 'Выберите склад';
    }
  }

  String _selectFromWarehouseTitle(CreateApplicationApplicationType type) {
    switch (type) {
      case CreateApplicationApplicationType.send:
        return 'Выберите склад отправки';
      case CreateApplicationApplicationType.recieve:
        return 'Выберите склад отправки (необязательно)';
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        return 'Выберите склад';
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
            case CreateApplicationStateData():
              switch (state.step) {
                case CreateApplicationStepSelectType():
                  return _CreateApplicationScreenType(
                    onTypeSelected: (type) =>
                        CreateApplicationBloc.of(context).add(
                      CreateApplicationEventOnTypeSelected(type),
                    ),
                    savedType: state.type,
                  );
                case CreateApplicationStepSelectToWarehouse():
                  return _CreateApplicationScreenWarehouse(
                    availableWarehouses: state.availableWarehouses,
                    title: _selectToWarehouseTitle(state.type!),
                    onWarehouseSelected: (warehose) {
                      if (warehose != null) {
                        CreateApplicationBloc.of(context).add(
                          CreateApplicationEventOnToWarehouseSelected(warehose),
                        );
                      }
                    },
                    selectedWarehouseId: state.toWarehouse?.id,
                    onBackButtonTap: state.canGoBack
                        ? () => CreateApplicationBloc.of(context).add(
                              CreateApplicationEventShowPreviousStep(),
                            )
                        : null,
                    canSkipStep: false,
                  );
                case CreateApplicationStepSelectFromWarehouse():
                  return _CreateApplicationScreenWarehouse(
                    // from и to не могут быть одинаковыми
                    availableWarehouses: state.availableWarehouses
                        .where((w) => w.id != state.toWarehouse?.id)
                        .toList(),
                    title: _selectFromWarehouseTitle(state.type!),
                    onWarehouseSelected: (warehose) =>
                        CreateApplicationBloc.of(context).add(
                      CreateApplicationEventOnFromWarehouseSelected(warehose),
                    ),
                    selectedWarehouseId: state.fromWarehouse?.id,
                    canSkipStep:
                        (state.step as CreateApplicationStepSelectFromWarehouse)
                            .canSkip,
                    onBackButtonTap: state.canGoBack
                        ? () => CreateApplicationBloc.of(context).add(
                              CreateApplicationEventShowPreviousStep(),
                            )
                        : null,
                  );
                case CreateApplicationStepSelectProducts():
                  return _SelectProducts(
                    products: state.selectedProducts ?? [],
                    onAddProductsTap: () =>
                        CreateApplicationBloc.of(context).add(
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
                    onBackTap: () => CreateApplicationBloc.of(context).add(
                      CreateApplicationEventShowPreviousStep(),
                    ),
                  );
                case CreateApplicationStepSave():
                  return _CreateApplication(
                    state: state,
                    onCreateTap: () => CreateApplicationBloc.of(context).add(
                      const CreateApplicationSaveButtonTap(),
                    ),
                    onBackTap: () => CreateApplicationBloc.of(context).add(
                      CreateApplicationEventShowPreviousStep(),
                    ),
                    saveDescription: (description) =>
                        CreateApplicationBloc.of(context).add(
                      CreateApplicationOnDescriptionChanged(
                        description: description,
                      ),
                    ),
                    onEditProducts: () => CreateApplicationBloc.of(context).add(
                      CreateApplicationEditProducts(),
                    ),
                  );
              }
          }
        },
      );
}
