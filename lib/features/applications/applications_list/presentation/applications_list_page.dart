import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../bloc/bloc.dart';
import 'components/info.dart';

class ApplicationsListPage extends StatefulWidget {
  const ApplicationsListPage({super.key});

  @override
  State<ApplicationsListPage> createState() => _ApplicationsListPageState();
}

class _ApplicationsListPageState extends State<ApplicationsListPage> {
  late final scrollController = ScrollController();
  static const _extentToLoadMore = 200;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScrollControllerPositionChanged);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ApplicationsListBloc.of(context).add(
        ApplicationsListEventInitialize(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ApplicationsListBloc, ApplicationsListState>(
        bloc: ApplicationsListBloc.of(context),
        builder: (context, state) => OskScaffold.slivers(
          scrollController: scrollController,
          header: OskScaffoldHeader(
            leading: const OskServiceIcon.request(),
            title: 'Заявки',
            actions: const [
              OskCloseIconButton(),
              SizedBox(width: 8),
            ],
          ),
          slivers: [
            Builder(
              builder: (context) {
                switch (state) {
                  case ApplicationsListStateIdle():
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case ApplicationsListStateData():
                    if (state.applications.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: OskText.body(
                              textAlign: TextAlign.center,
                              text: 'Заявок пока нет',
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      sliver: SliverList.separated(
                        itemBuilder: (context, index) {
                          if (index == state.applications.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final item = state.applications[index];
                          return ApplicationInfo(
                            request: item,
                            onTap: () => ApplicationsListBloc.of(context).add(
                              ApplicationListEventOnApplicationTap(item.id),
                            ),
                          );
                        },
                        itemCount:
                            state.applications.length + (state.hasMore ? 1 : 0),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      );

  void _onScrollControllerPositionChanged() {
    final bloc = ApplicationsListBloc.of(context);
    final state = bloc.state;
    if (scrollController.position.extentAfter <= _extentToLoadMore &&
        state is ApplicationsListStateData &&
        state.hasMore) {
      bloc.add(ApplicationListEventOnLoadMore());
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScrollControllerPositionChanged)
      ..dispose();
    super.dispose();
  }
}
