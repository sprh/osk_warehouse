import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../bloc/bloc.dart';

class ApplicationsListPage extends StatefulWidget {
  const ApplicationsListPage({super.key});

  @override
  State<ApplicationsListPage> createState() => _ApplicationsListPageState();
}

class _ApplicationsListPageState extends State<ApplicationsListPage> {
  @override
  void initState() {
    super.initState();
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
                }
              },
            ),
          ],
        ),
      );
}
