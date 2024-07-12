import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';
import 'package:learn_europe/constants/textstyles.dart';
import 'package:learn_europe/network/data_fetching.dart';
import 'package:learn_europe/service_locator.dart';
import 'package:learn_europe/stores/avatar_selection_dialog_store.dart';
import 'package:learn_europe/stores/cta_button_loading_store.dart';
import 'package:learn_europe/stores/user_store.dart';
import 'cta_button.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? AppColors.lightBackground
                    : AppColors.darkBackground,
                backgroundImage: AssetImage(
                  'assets/${getIt<UserStore>().avatar ?? 'avatar_blue'}.png',
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -15,
              child: Container(
                padding: const EdgeInsets.all(AppPaddings.padding_8),
                decoration: BoxDecoration(
                  color: MediaQuery.of(context).platformBrightness == Brightness.light
                      ? AppColors.primaryColorLight
                      : AppColors.primaryColorDark,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.edit,
                  color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.black,
                  size: 17.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SelectAvatarDialog extends StatefulWidget {
  const SelectAvatarDialog({super.key});

  @override
  SelectAvatarDialogState createState() => SelectAvatarDialogState();
}

class SelectAvatarDialogState extends State<SelectAvatarDialog> {
  AvatarSelectionDialogStore avatarSelectionDialogStore = AvatarSelectionDialogStore();
  CtaButtonLoadingStore ctaButtonLoadingStore = CtaButtonLoadingStore();

  @override
  void initState() {
    super.initState();
    avatarSelectionDialogStore.setAvatar(getIt<UserStore>().avatar ?? 'avatar_blue');
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Dialog(
          elevation: 1,
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPaddings.padding_16),
          child: Padding(
            padding: const EdgeInsets.all(AppPaddings.padding_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.selectAvatarTitle, style: AppTextStyles.sectionTitleTextStyle),
                const SizedBox(height: AppPaddings.padding_8),
                Flexible(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: AppPaddings.padding_8,
                    mainAxisSpacing: AppPaddings.padding_8,
                    children: [
                      AvatarCard(
                        imageUrl: 'assets/avatar_blue.png',
                        isSelected: 'avatar_blue' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_blue'),
                      ),
                      AvatarCard(
                        imageUrl: 'assets/avatar_yellow.png',
                        isSelected: 'avatar_yellow' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_yellow'),
                      ),
                      AvatarCard(
                        imageUrl: 'assets/avatar_green.png',
                        isSelected: 'avatar_green' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_green'),
                      ),
                      AvatarCard(
                        imageUrl: 'assets/avatar_red.png',
                        isSelected: 'avatar_red' == avatarSelectionDialogStore.selectedAvatar,
                        onTap: () => avatarSelectionDialogStore.setAvatar('avatar_red'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppPaddings.padding_24),
                CtaButton.primary(
                  loading: ctaButtonLoadingStore.isLoading,
                  onPressed: () async {
                    ctaButtonLoadingStore.setLoading();
                    await changeUserAvatar(avatarSelectionDialogStore.selectedAvatar);
                    if (context.mounted) {
                      ctaButtonLoadingStore.resetLoading();
                      Navigator.of(context).pop();
                    }
                  },
                  label: AppStrings.selectAvatarButton,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.imageUrl, required this.isSelected, required this.onTap});

  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.lightCard
                  : AppColors.darkCard,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected
                    ? MediaQuery.of(context).platformBrightness == Brightness.light
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark
                    : Colors.black12,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 0.5,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppPaddings.padding_4),
            child: Image.asset(imageUrl),
          ),
          if (isSelected)
            Positioned(
              right: 5,
              bottom: 5,
              child: Icon(
                Icons.check_circle,
                color: MediaQuery.of(context).platformBrightness == Brightness.light
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
              ),
            ),
        ],
      ),
    );
  }
}
