part of '../create_appication_page.dart';

class _CreateApplicationScreenType extends StatefulWidget {
  final void Function(ApplicationType) onTypeSelected;

  const _CreateApplicationScreenType({required this.onTypeSelected});

  @override
  State<_CreateApplicationScreenType> createState() =>
      _CreateApplicationScreenTypeState();
}

class _CreateApplicationScreenTypeState
    extends State<_CreateApplicationScreenType> {
  ApplicationType? applicationType;

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
            onTap: applicationType
                    ?.let((type) => () => widget.onTypeSelected(type)) ??
                () {},
          ),
        ],
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectApplicationTypeWidget(
                    name: 'Отправить',
                    selected: applicationType == ApplicationType.send,
                    onSelect: () {
                      applicationType = ApplicationType.send;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  SelectApplicationTypeWidget(
                    name: 'Принять',
                    selected: applicationType == ApplicationType.recieve,
                    onSelect: () {
                      applicationType = ApplicationType.recieve;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  SelectApplicationTypeWidget(
                    name: 'Браковать',
                    selected: applicationType == ApplicationType.defect,
                    onSelect: () {
                      applicationType = ApplicationType.defect;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  SelectApplicationTypeWidget(
                    name: 'Использовать',
                    selected: applicationType == ApplicationType.use,
                    onSelect: () {
                      applicationType = ApplicationType.use;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
