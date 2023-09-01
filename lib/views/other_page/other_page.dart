import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/services/user_web_services.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/utils/constants/spaces.dart';
import 'package:merostore_mobile/utils/constants/text_styles.dart';
import 'package:merostore_mobile/views/auth_page/auth_page.dart';
import 'package:merostore_mobile/views/core_widgets/custom_box.dart';
import 'package:merostore_mobile/views/core_widgets/custom_shadow_container.dart';
import 'package:merostore_mobile/views/edit_store_page/edit_store_page.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_list_tile.dart';

/// Handles every settings related to user

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: SvgPicture.network(
                    "https://avatars.dicebear.com/api/bottts/s.svg"),
              ),
              ConstantSpaces.width8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Sulabh Shrestha",
                    style: ConstantTextStyles.blueHeading22,
                  ),
                  Text(
                    "+9771231231234",
                    style: ConstantTextStyles.dimStyle14,
                  )
                ],
              ),
            ],
          ),
        ),
        ConstantSpaces.height8,
        // Content
        CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
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
                  final Stores stores =
                      Provider.of<Stores>(context, listen: false);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListenableProvider<Stores>.value(
                        value: stores,
                        child: const EditStorePage(title: "Edit stores"),
                      ),
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
        CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
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
        CustomBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
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
