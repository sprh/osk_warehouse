import 'package:flutter/material.dart';

import '../../../../../common/components/osk_line_divider.dart';
import '../../../../../common/components/tap/osk_tap_animation.dart';
import '../../../../../common/components/text/osk_text.dart';
import '../../../../../common/theme/utils/theme_from_context.dart';
import '../../../../../l10n/utils/application_data_mapper.dart';
import '../../../models/application/appication_type.dart';
import '../../../models/application/application.dart';
import 'info_status.dart';

part 'application_info_header.dart';

class ApplicationInfo extends StatelessWidget {
  final Application application;
  final VoidCallback onTap;

  const ApplicationInfo({
    required this.application,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.requestInfoTheme;
    final size = MediaQuery.of(context).size;
    final applicationData = application.data;

    return OskTapAnimationBuilder(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: theme.shadow, blurRadius: 8),
          ],
          color: theme.background,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width / 10 * 9,
            maxWidth: size.width / 10 * 9,
            minHeight: size.height / 12,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _ApplicationInfoHeader(
                  applicationType: applicationData.type,
                  fromWarehouseName:
                      applicationData.sentFromWarehouse?.warehouseName,
                  toWarehouseName:
                      applicationData.sentToWarehouse?.warehouseName,
                ),
                ApplicationInfoStatus(
                  status: application.data.status,
                  updatedAt: application.updatedAt,
                  createdAt: application.updatedAt,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: OskLineDivider(),
                ),
                OskText.body(text: application.data.createdBy.fullName),
                const SizedBox(height: 8),
                OskText.body(
                  text: application.data.description,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
