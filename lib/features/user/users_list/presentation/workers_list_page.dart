import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/info_slot/osk_info_slot.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => UserListBloc.of(context).add(UserListEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UserListBloc, UserListState>(
        bloc: UserListBloc.of(context),
        builder: (context, state) => OskScaffold.slivers(
          header: OskScaffoldHeader(
            leading: const OskServiceIcon.worker(),
            title: 'Сотрудники',
            actions: const [
              OskCloseIconButton(),
              SizedBox(width: 8),
            ],
          ),
          slivers: [
            Builder(
              builder: (context) {
                switch (state) {
                  case UserListInitialState():
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case UserListDataState():
                    if (state.users.isEmpty) {
                      return SliverFillRemaining(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: OskText.body(
                              text:
                                  'Пользователей пока нет. Нажмите на кнопку Добавить, чтобы создать',
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverList.separated(
                        itemCount: state.users.length,
                        itemBuilder: (_, index) {
                          final user = state.users[index];

                          return Center(
                            child: OskInfoSlot.dismissible(
                              title: user.fullName,
                              subtitle: user.username,
                              leading: user.isCurrentUser
                                  ? OskText.caption(
                                      text: 'Вы',
                                      colorType:
                                          OskTextColorType.highlightedYellow,
                                    )
                                  : null,
                              onTap: () => UserListBloc.of(context).add(
                                UserListUserTapEvent(user.username),
                              ),
                              dismissibleKey: ValueKey(user.username),
                              onDelete: user.isCurrentUser || !state.canEditData
                                  ? null
                                  : () {
                                      UserListBloc.of(context).add(
                                        UserListEventDeleteUser(user.username),
                                      );
                                      return Future.value(false);
                                    },
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                      ),
                    );
                }
              },
            ),
          ],
          actions: [
            if (state is UserListDataState && state.canEditData)
              OskButton.main(
                title: 'Добавить',
                onTap: () => UserListBloc.of(context).add(
                  UserListEventAddNewUser(),
                ),
              ),
          ],
        ),
      );
}
