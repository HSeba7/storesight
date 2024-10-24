import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/client_cubit/cubit.dart';
import 'package:storesight/view_models/client_cubit/states.dart';
import 'package:storesight/views/auth_views/tutorial_view.dart';
import 'package:storesight/views/client_views/scan_view.dart';
import 'package:storesight/views/client_views/widgets/nav_icon.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<ClientCubit, ClientStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ClientCubit cubit = ClientCubit.get(context);
          return Scaffold(
            backgroundColor: color.primaryColor,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: cubit.views[cubit.index],
            ),
            bottomNavigationBar: SizedBox(
              width: double.infinity,
              height: height(90),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: color.primaryColorDark,
                selectedLabelStyle: TextStyle(
                  color: color.primaryColor,
                  fontSize: width(12),
                ),
                unselectedLabelStyle: TextStyle(
                  color: color.primaryColorLight,
                  fontSize: width(12),
                ),
                items: const [
                  BottomNavigationBarItem(
                    icon: NavIcon(
                      icon: "assets/icons/home.svg",
                      label: "Tutorial",
                    ),
                    label: "Tutorial",
                  ),
                  BottomNavigationBarItem(
                    icon: NavIcon(
                      leading: true,
                      icon: "assets/icons/profile.svg",
                      label: "Mój Profil",
                    ),
                    label: "Mój Profil",
                  ),
                ],
                currentIndex: cubit.index,
                onTap: (value) {
                  printLn(value);
                  if (value == 0 && cubit.index == 0) {
                    navigateTo(
                      view: TutorialView(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      context: context,
                    );
                  } else {
                    cubit.changeIndex(value);
                  }
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: GestureDetector(
              onTap: () {
                navigateTo(
                  view: const ScanView(),
                  context: context,
                );
              },
              child: Container(
                width: width(90),
                height: height(90),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.primaryColor.withOpacity(0.55),
                ),
                child: Center(
                  child: Container(
                    width: width(80),
                    height: height(80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.primaryColor,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/scan.svg',
                      width: width(26),
                      height: height(29),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
