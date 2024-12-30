import 'package:event_planning/ui/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/event_item_widget.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyle.bold14Primary,
              borderColor: AppColors.primaryLight,
              style: AppStyle.medium16Primary,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primaryLight,
                size: 30,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return EventItemWidget();
                },
                itemCount: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
