import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/button/osk_close_icon_button.dart';
import '../../../common/components/icon/osk_service_icons.dart';
import '../../../common/components/loading_effect/loading_effect.dart';
import '../../../common/components/scaffold/osk_scaffold.dart';
import '../../../common/components/text/osk_text.dart';
import '../bloc/bloc.dart';

class ReportsListPage extends StatefulWidget {
  const ReportsListPage({super.key});

  @override
  State<ReportsListPage> createState() => _ReportsListPageState();
}

class _ReportsListPageState extends State<ReportsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ReportsBloc.of(context).add(ReportsEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) => OskScaffold(
          header: OskScaffoldHeader(
            leading: const OskServiceIcon.report(),
            title: 'Товары',
            actions: const [
              OskCloseIconButton(),
              SizedBox(width: 8),
            ],
          ),
          body: Builder(
            builder: (context) {
              switch (state) {
                case ReportsStateNoSelectedPeriod():
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      _PeriodButton(
                        onTap: () => ReportsBloc.of(context).add(
                          ReportsEventOpenCalendar(),
                        ),
                        formattedPeriod: null,
                      ),
                    ],
                  );
                case ReportsStateSelectedPeriod():
                  final report = state.response;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      _PeriodButton(
                        onTap: () => ReportsBloc.of(context).add(
                          ReportsEventOpenCalendar(),
                        ),
                        formattedPeriod: state.formattedPeriod,
                      ),
                      if (report.items.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: OskText.body(
                            text: 'Нет данных за заданный период',
                          ),
                        )
                      else
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: report.header
                                .map(
                                  (e) =>
                                      DataColumn(label: OskText.body(text: e)),
                                )
                                .toList(),
                            rows: report.items
                                .map(
                                  (item) => DataRow(
                                    cells: item
                                        .map(
                                          (e) => DataCell(
                                            OskText.body(
                                              text: e == null
                                                  ? '-'
                                                  : e.toString(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                    ],
                  );
                case ReportsStateSelectedPeriodLoading():
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      LoadingEffect(
                        child: _PeriodButton(
                          onTap: () => ReportsBloc.of(context).add(
                            ReportsEventOpenCalendar(),
                          ),
                          formattedPeriod: state.formattedPeriod,
                        ),
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
              }
            },
          ),
        ),
      );
}

class _PeriodButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? formattedPeriod;

  const _PeriodButton({
    required this.onTap,
    required this.formattedPeriod,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => ReportsBloc.of(context).add(
          ReportsEventOpenCalendar(),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: OskText.title2(
              text: formattedPeriod == null
                  ? 'Нажмите, чтобы выбрать период'
                  : formattedPeriod!,
              fontWeight: OskfontWeight.bold,
            ),
          ),
        ),
      );
}
