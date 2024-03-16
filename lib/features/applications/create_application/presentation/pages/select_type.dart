part of '../create_appication_page.dart';

class _CreateApplicationScreenType extends StatefulWidget {
  final void Function(OskApplicationType) onTypeSelected;

  const _CreateApplicationScreenType({required this.onTypeSelected});

  @override
  State<_CreateApplicationScreenType> createState() =>
      _CreateApplicationScreenTypeState();
}

class _CreateApplicationScreenTypeState
    extends State<_CreateApplicationScreenType> {
  OskApplicationType? applicationType;

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
                    selected: applicationType == OskApplicationType.send,
                    onSelect: () {
                      applicationType = OskApplicationType.send;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  SelectApplicationTypeWidget(
                    name: 'Принять',
                    selected: applicationType == OskApplicationType.recieve,
                    onSelect: () {
                      applicationType = OskApplicationType.recieve;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  SelectApplicationTypeWidget(
                    name: 'Браковать',
                    selected: applicationType == OskApplicationType.defect,
                    onSelect: () {
                      applicationType = OskApplicationType.defect;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  SelectApplicationTypeWidget(
                    name: 'Использовать',
                    selected: applicationType == OskApplicationType.use,
                    onSelect: () {
                      applicationType = OskApplicationType.use;
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
