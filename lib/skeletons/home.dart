import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/logo.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:qwid/providers/data/card.dart';
import 'package:qwid/screens/home/components/card_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homePro, chi9ld) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: homePro.selectedIndex == 0
                ? Logo(
                    size: 24,
                  )
                : Text(
                    homePro.tabTitles[homePro.selectedIndex],
                    style: const CustomTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.labelText,
                    ),
                  ),
            actions: [
              if (homePro.selectedIndex == 1)
                Consumer<CardData>(builder: (context, data, chi9ld) {
                  return data.virtualCard == null
                      ? const SizedBox.shrink()
                      : CardButton(card: data.virtualCard!);
                })
            ],
          ),
          body: homePro.tabs[homePro.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: CustomColors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              currentIndex: homePro.selectedIndex,
              onTap: (index) async {
                if (index == 1) {
                  CardData cardData =
                      Provider.of<CardData>(context, listen: false);
                  cardData.virtualCards = null;
                }
                homePro.selectedIndex = index;
              },
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedLabelStyle: const CustomTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: CustomColors.primary,
              ),
              unselectedLabelStyle: CustomTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: CustomColors.labelText.withOpacity(0.5),
              ),
              items: homePro.tabTitles
                  .map(
                    (e) => BottomNavigationBarItem(
                      label: e,
                      icon: Opacity(
                        opacity: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 4,
                          ),
                          child: CustomIcon(
                            height: 20,
                            icon: e.toLowerCase(),
                          ),
                        ),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: CustomIcon(
                          height: 20,
                          icon: '${e.toLowerCase()}_selected',
                        ),
                      ),
                    ),
                  )
                  .toList()),
        );
      },
    );
  }
}
