import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merostore_mobile/providers/store_provider.dart';
import 'package:merostore_mobile/providers/user_provider.dart';
import 'package:merostore_mobile/services/user_web_services.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/view_models/local_storage_view_model.dart';
import 'package:merostore_mobile/view_models/user_view_model.dart';
import 'package:merostore_mobile/views/auth_page/auth_page.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_shadow_container.dart';
import 'package:merostore_mobile/views/store_page/store_page.dart';
import 'widgets/custom_list_tile.dart';

/// Handles every settings related to user

class OtherPage extends ConsumerWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        // User image, name, number
        CustomBox(
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 36,
                backgroundColor: ConstantAppColors.redColor,
                child:
                    Image.network(ref.read(userProvider).photoUrl.toString()),
              ),
              ConstantSpaces.width8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ref.read(userProvider).name.toString(),
                    style: ConstantTextStyles.blueHeading22,
                  ),
                  Text(
                    ref.read(userProvider).email.toString(),
                    style: ConstantTextStyles.dimStyle14,
                  )
                ],
              ),
            ],
          ),
        ),
        ConstantSpaces.height8,
        // Content
        const CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Content",
                style: ConstantTextStyles.redHeading20,
              ),
              ConstantSpaces.height4,
              CustomListTile(
                title: "Download",
                googleIconData: Icons.download_for_offline_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
            ],
          ),
        ),
        ConstantSpaces.height8,

        // Preferences
        CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Preferences",
                style: ConstantTextStyles.redHeading20,
              ),
              ConstantSpaces.height4,
              const CustomListTile(
                title: "Personal data",
                googleIconData: Icons.contact_page_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),

              CustomListTile(
                title: "Stores",
                googleIconData: Icons.store_outlined,
                trailingIcon: const Icon(Icons.navigate_next_outlined),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StorePage(),
                    ),
                  );
                },
              ),
              const CustomListTile(
                title: "Language",
                googleIconData: Icons.language_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),

              // when turned on, leadingIconData: light_mode
              const CustomListTile(
                title: "Dark mode",
                googleIconData: Icons.light_mode_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
            ],
          ),
        ),
        ConstantSpaces.height8,

        // Support
        const CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Support",
                style: ConstantTextStyles.redHeading20,
              ),
              ConstantSpaces.height4,
              CustomListTile(
                title: "Bug report",
                googleIconData: Icons.bug_report_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
              CustomListTile(
                title: "Leave feedback",
                googleIconData: Icons.feedback_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
            ],
          ),
        ),
        ConstantSpaces.height8,

        // Other
        const CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Other",
                style: ConstantTextStyles.redHeading20,
              ),
              ConstantSpaces.height4,
              CustomListTile(
                title: "Tell your fiend",
                googleIconData: Icons.share_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
              CustomListTile(
                title: "Rate us",
                googleIconData: Icons.star_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
              CustomListTile(
                title: "Contact us",
                googleIconData: Icons.email_outlined,
                trailingIcon: Icon(Icons.navigate_next_outlined),
              ),
            ],
          ),
        ),

        ConstantSpaces.height16,

        // Sign out
        Center(
          child: CustomShadowContainer(
            onTap: () async {
              log("Going to logout");
              UserWebServices()
                  .logout()
                  .then((value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const AuthPage()),
                      ))
                  .onError((error, stackTrace) => log(error.toString()));
            },
            height: 46,
            width: MediaQuery.of(context).size.width * 0.4,
            foregroundColor: ConstantAppColors.redColor,
            backgroundColor: ConstantAppColors.yellowColor,
            child: const Center(
              child: Text(
                "Sign out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        ConstantSpaces.height8,
      ],
    );
  }
}
