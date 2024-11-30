import 'dart:math';

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
import '../../../../l10n/utils/application_data_mapper.dart';
import '../../applications_list/presentation/components/info_status.dart';
import '../../models/application/application_actions.dart';
import '../bloc/bloc.dart';

class ApplicationDataPage extends StatefulWidget {
  const ApplicationDataPage({super.key});

  @override
  State<ApplicationDataPage> createState() => _ApplicationDataPageState();
}

class _ApplicationDataPageState extends State<ApplicationDataPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ApplicationDataBloc.of(context).add(
        ApplicationDataEventInitialize(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ApplicationDataBloc, ApplicationDataState>(
        builder: (context, state) {
          switch (state) {
            case ApplicationDataStateIdle():
              return OskScaffold.slivers(
                header: OskScaffoldHeader(
                  leading: const OskServiceIcon.request(),
                  title: 'Заявка',
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
            case ApplicationDataStateData():
              final items = state.application.products;
              final actions = state.application.actions;

              return OskScaffold(
                header: OskScaffoldHeader.customTitle(
                  titleWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OskText.title1(
                        text: 'Заявка #${state.application.data.serialNumber}',
                        fontWeight: OskfontWeight.bold,
                      ),
                      ApplicationInfoStatus(
                        status: state.application.data.status,
                        updatedAt: state.application.updatedAt,
                        createdAt: state.application.createdAt,
                      ),
                    ],
                  ),
                  leading: const OskServiceIcon.request(),
                  actions: const [
                    OskCloseIconButton(),
                    SizedBox(width: 8),
                  ],
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _ApplicationCommonInfo(
                        state,
                        (username) => ApplicationDataBloc.of(context).add(
                          ApplicationDataEventOnUserTap(username),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: OskText.title2(
                        text: 'Товары',
                        fontWeight: OskfontWeight.bold,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: items.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) {
                        final product = items[index];

                        return Center(
                          child: OskInfoSlot(
                            title: product.name,
                            onTap: () => ApplicationDataBloc.of(context).add(
                              ApplicationDataEventOnItemTap(product.id),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OskText.caption(
                                  text: '${product.count} шт',
                                  fontWeight: OskfontWeight.medium,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                actionsDirection: Axis.horizontal,
                customActions: actions.isNotEmpty
                    ? OskActionsFlex(
                        direction: Axis.vertical,
                        maxWidth: MediaQuery.of(context).size.width,
                        widgets: [
                          OskActionsFlex(
                            maxWidth: MediaQuery.of(context).size.width,
                            widgets: actions
                                .take(min(2, actions.length))
                                .map(
                                  (e) => _ApplicationAction(
                                    e,
                                    () => ApplicationDataBloc.of(context).add(
                                      ApplicationDataEventOnActionTap(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          if (actions.length > 2)
                            OskActionsFlex(
                              maxWidth: MediaQuery.of(context).size.width,
                              widgets: actions
                                  .skip(2)
                                  .take(min(2, actions.length - 2))
                                  .map(
                                    (e) => _ApplicationAction(
                                      e,
                                      () => ApplicationDataBloc.of(context).add(
                                        ApplicationDataEventOnActionTap(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                        ],
                      )
                    : null,
              );
          }
        },
      );
}

class _ApplicationCommonInfo extends StatelessWidget {
  final ApplicationDataStateData state;
  final void Function(String) onUserTap;

  const _ApplicationCommonInfo(this.state, this.onUserTap);

  @override
  Widget build(BuildContext context) {
    final finishedBy = state.application.data.finishedBy;
    final createdBy = state.application.data.createdBy;
    final fromWarehouse = state.application.data.sentFromWarehouse;
    final toWarehouse = state.application.data.sentToWarehouse;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OskText.body(
          text: 'Тип заявки',
          fontWeight: OskfontWeight.bold,
        ),
        OskText.body(
          text: ApplicationDataMapper.getApplicationTypeAsString(
            state.application.data.type,
          ),
        ),
        const SizedBox(height: 8),
        const OskLineDivider(),
        const SizedBox(height: 8),
        OskText.body(
          text: 'Заявка создана',
          fontWeight: OskfontWeight.bold,
        ),
        const SizedBox(height: 8),
        OskInfoSlot(
          title: createdBy.fullName,
          subtitle: createdBy.username,
          onTap: () => onUserTap(createdBy.username),
        ),
        if (finishedBy != null) ...[
          const SizedBox(height: 8),
          OskText.body(
            text: 'Заявка завершена',
            fontWeight: OskfontWeight.bold,
          ),
          const SizedBox(height: 8),
          OskInfoSlot(
            title: finishedBy.fullName,
            subtitle: finishedBy.username,
            onTap: () => onUserTap(finishedBy.username),
          ),
        ],
        const SizedBox(height: 8),
        OskText.caption(text: 'Описание'),
        const SizedBox(height: 8),
        OskText.body(
          text: state.application.data.description,
          colorType: OskTextColorType.minor,
        ),
        const SizedBox(height: 8),
        const OskLineDivider(),
        const SizedBox(height: 8),
        if (fromWarehouse != null) ...[
          OskText.title2(
            text: ApplicationDataMapper.getApplicationFromWarehouseTitleByType(
              state.application.data.type,
            ),
            fontWeight: OskfontWeight.bold,
          ),
          const SizedBox(height: 4),
          OskText.body(text: fromWarehouse.warehouseName),
          OskText.caption(
            text: fromWarehouse.warehouseName,
            colorType: OskTextColorType.minor,
          ),
          const SizedBox(height: 8),
        ],
        if (fromWarehouse != null && toWarehouse != null) ...[
          const Icon(Icons.arrow_downward_rounded),
          const SizedBox(height: 8),
        ],
        if (toWarehouse != null) ...[
          OskText.title2(
            text: ApplicationDataMapper.getApplicationToWarehouseTitleByType(
                  state.application.data.type,
                ) ??
                '',
            fontWeight: OskfontWeight.bold,
          ),
          const SizedBox(height: 4),
          OskText.body(text: toWarehouse.warehouseName),
          OskText.caption(
            text: toWarehouse.warehouseName,
            colorType: OskTextColorType.minor,
          ),
          const SizedBox(height: 8),
        ],
        const OskLineDivider(),
      ],
    );
  }
}

class _ApplicationAction extends StatelessWidget {
  final ApplicationAction type;
  final VoidCallback onTap;

  const _ApplicationAction(this.type, this.onTap);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ApplicationAction.approve:
        return OskButton.main(
          title: 'Подтвердить',
          onTap: onTap,
        );
      case ApplicationAction.reject:
        return OskButton.minor(
          title: 'Отклонить',
          onTap: onTap,
        );
      case ApplicationAction.edit:
        return OskButton.main(
          title: 'Редактировать',
          onTap: onTap,
        );
      case ApplicationAction.delete:
        return OskButton.minor(
          title: 'Удалить',
          onTap: onTap,
        );
    }
  }
}
