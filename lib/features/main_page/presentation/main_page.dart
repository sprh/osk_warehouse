import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/icon/osk_service_icons.dart';
import '../../../common/components/osk_action_block.dart';
import '../../../common/components/scaffold/osk_scaffold.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';
import 'components/main_page_header.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => MainPageBloc.of(context).add(MainPageEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return BlocBuilder<MainPageBloc, MainPageState>(
      bloc: MainPageBloc.of(context),
      builder: (context, state) {
        return OskScaffold.slivers(
          appBar: const SliverAppBar(
            pinned: true,
            // actions: [
            //   OskIconButton(
            //     icon: const OskIcon.notification(),
            //     onTap: () {}, // TODO:
            //   ),
            //   const SizedBox(width: 16),
            //   OskIconButton(
            //     icon: const OskIcon.setting(),
            //     onTap: () {}, // TODO:
            //   ),
            //   const SizedBox(width: 16),
            // ],
          ),
          slivers: [
            if (state is MainPageStateIdle)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state is MainPageStateData) ...[
              SliverToBoxAdapter(child: MainPageHeader(name: state.userName)),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  children: [
                    if (state.availableBlocks
                        .contains(MainPageBlocks.createRequest))
                      OskActionBlock(
                        title: strings.createRequest,
                        icon: const OskServiceIcon.createRequest(),
                        onTap: () => MainPageBloc.of(context).add(
                          MainPageEventOpenCreateApplication(),
                        ),
                        notificationsCount: 9,
                      ),
                    if (state.availableBlocks.contains(MainPageBlocks.requests))
                      OskActionBlock(
                        title: strings.requests,
                        icon: const OskServiceIcon.request(),
                        onTap: () => MainPageBloc.of(context).add(
                          MainPageEventOpenRequestsList(),
                        ),
                      ),
                    if (state.availableBlocks
                        .contains(MainPageBlocks.warehouses))
                      OskActionBlock(
                        title: strings.warehouses,
                        icon: const OskServiceIcon.warehouse(),
                        onTap: () => MainPageBloc.of(context).add(
                          MainPageEventOpenWarehouseList(),
                        ),
                      ),
                    if (state.availableBlocks.contains(MainPageBlocks.workers))
                      OskActionBlock(
                        title: strings.workers,
                        icon: const OskServiceIcon.worker(),
                        onTap: () => MainPageBloc.of(context).add(
                          MainPageEventOpenWorkersList(),
                        ),
                      ),
                    // if (state.availableBlocks.contains(MainPageBlocks.reports))
                    //   OskActionBlock(
                    //     title: strings.reports,
                    //     icon: const OskServiceIcon.report(),
                    //     onTap: () {}, // TODO:,
                    //   ),
                    if (state.availableBlocks.contains(MainPageBlocks.products))
                      OskActionBlock(
                        title: strings.productCards,
                        icon: const OskServiceIcon.products(),
                        onTap: () => MainPageBloc.of(context).add(
                          MainPageEventOpenProductsList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
