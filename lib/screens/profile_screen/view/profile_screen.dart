import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import 'package:remindme/features/custom_text_button/view/custom_text_button.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/models/user.dart';
import '../../../core/routes/app_routes.dart';
import '../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileScreenController cc = Get.put(
      ProfileScreenController(),
      tag: 'profile_screen',
      permanent: true,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        title: 'Mon profil',
        onPressed: () {},
        isLeadingWithCustomArrow: true,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: "bottomAppBar",
      ),
      body: Center(
        child: Container(
          width: 300.0,
          child: StreamBuilder<User>(
            stream: cc.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(children: [
                  const CustomSpace(heightMultiplier: 4),
                  PhysicalModel(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(70),
                    elevation: 3.0,
                    shadowColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                      radius: 60,
                    ),
                  ),
                  const CustomSpace(heightMultiplier: 3),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 20, color: CustomColors.mainBlue),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Nom : ${user.name}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              const CustomSpace(heightMultiplier: 1),
                              Row(
                                children: [
                                  const Icon(Icons.email,
                                      size: 20, color: CustomColors.mainBlue),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Email : ${user.email}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const CustomSpace(heightMultiplier: 35),
                  CustomFABButton(
                    text: 'Déconnexion',
                    onPressed: () {
                      cc.signOut();
                    },
                    tag: 'signOutButton',
                    backgroundColor: CustomColors.interaction,
                  ),
                ]);
              } else {
                return Text('Chargement...');
              }
            },
          ),
        ),
      ),
    );
  }
}
