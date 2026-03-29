import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../core/utils/load_data.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/text/sub_label.dart';
import '../models/privacy_model.dart';
import '../widgets/privacy_item_card.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text("Privacy & Data Protection"),
      ),
      body: SingleChildScrollView(
        padding: Config.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubLabel(
              text:
                  "Your privacy is important to us. This page explains how your information is collected, used, and protected within the application.",
            ),
            FutureBuilder<List<PrivacyModel>>(
              future: LoadDataFromJson().loadPrivacy(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: LoadingIndicator(size: 25));
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<PrivacyModel> privacies = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 25,
                    children: List.generate(privacies.length, (index) {
                      return PrivacyItemCard(privacy: privacies[index]);
                    }),
                  );
                } else {
                  return Text("No data available");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
