part of '../create_appication_page.dart';

class _CreateApplicationScreenType extends StatefulWidget {
  final void Function(CreateApplicationApplicationType) onTypeSelected;
  final CreateApplicationApplicationType? savedType;

  const _CreateApplicationScreenType({
    required this.onTypeSelected,
    required this.savedType,
  });

  @override
  State<_CreateApplicationScreenType> createState() =>
      _CreateApplicationScreenTypeState();
}

class _CreateApplicationScreenTypeState
    extends State<_CreateApplicationScreenType> {
  late CreateApplicationApplicationType? applicationType = widget.savedType;

  String _getNameByType(CreateApplicationApplicationType type) {
    switch (type) {
      case CreateApplicationApplicationType.send:
        return 'Отправить';
      case CreateApplicationApplicationType.recieve:
        return 'Принять';
      case CreateApplicationApplicationType.defect:
        return 'Браковать';
      case CreateApplicationApplicationType.use:
        return 'Использовать';
    }
  }

  @override
  Widget build(BuildContext context) => OskScaffold.slivers(
        header: OskScaffoldHeader(
          leading: const OskServiceIcon.request(),
          title: 'Выберите тип заявки',
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        actions: [
          OskButton.main(
            title: 'Далее',
            state: applicationType != null
                ? OskButtonState.enabled
                : OskButtonState.disabled,
            onTap: applicationType?.let(
                  (type) => () => widget.onTypeSelected(type),
                ) ??
                () {},
          ),
        ],
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final type
                      in CreateApplicationApplicationType.values) ...[
                    if (type != CreateApplicationApplicationType.values.first)
                      const SizedBox(height: 8),
                    SelectApplicationTypeWidget(
                      name: _getNameByType(type),
                      selected: applicationType == type,
                      onSelect: () => setState(
                        () => applicationType = type,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      );
}
