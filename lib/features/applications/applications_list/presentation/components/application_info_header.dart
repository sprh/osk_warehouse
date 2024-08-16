part of 'info.dart';

class _ApplicationInfoHeader extends StatefulWidget {
  final ApplicationType applicationType;
  final String? fromWarehouseName;
  final String? toWarehouseName;

  const _ApplicationInfoHeader({
    required this.applicationType,
    required this.fromWarehouseName,
    required this.toWarehouseName,
  });

  @override
  State<_ApplicationInfoHeader> createState() => _ApplicationInfoHeaderState();
}

class _ApplicationInfoHeaderState extends State<_ApplicationInfoHeader> {
  late String _applicationTypeFormatted;

  @override
  void initState() {
    super.initState();
    _applicationTypeFormatted =
        ApplicationDataMapper.getApplicationTypeAsString(
      widget.applicationType,
    );
  }

  @override
  Widget build(BuildContext context) {
    final from = widget.fromWarehouseName;
    final to = widget.toWarehouseName;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        OskText.body(
          text: '[$_applicationTypeFormatted]',
          fontWeight: OskfontWeight.bold,
        ),
        const SizedBox(width: 4),
        if (from != null && to != null) ...[
          OskText.body(
            text: from,
            fontWeight: OskfontWeight.bold,
          ),
          const Icon(
            Icons.arrow_forward_outlined,
            size: 16,
          ),
          OskText.body(
            text: to,
            fontWeight: OskfontWeight.bold,
          ),
        ] else if (to != null)
          OskText.body(
            text: to,
            fontWeight: OskfontWeight.bold,
          )
        else if (from != null)
          OskText.body(
            text: from,
            fontWeight: OskfontWeight.bold,
          ),
      ],
    );
  }
}
