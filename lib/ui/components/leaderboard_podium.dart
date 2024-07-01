import 'package:flutter/material.dart';
import 'package:learn_europe/constants/colors.dart';
import 'package:learn_europe/constants/paddings.dart';
import 'package:learn_europe/constants/strings.dart';

class LeaderboardPodium extends StatelessWidget {
  final int rank;
  final String username;
  final int totalPoints;
  final bool? isUser;

  const LeaderboardPodium({
    super.key,
    required this.rank,
    required this.username,
    required this.totalPoints,
    this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.height < 700;
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Container(
      width: MediaQuery.of(context).size.width * 0.275,
      height: (MediaQuery.of(context).size.height * (isSmallScreen ? 0.35 : 0.275)) - (rank - 1) * 25,
      decoration: BoxDecoration(
        color: (brightness == Brightness.light ? AppColors.primaryColorLight : AppColors.primaryColorDark).withOpacity(
          rank == 1 ? 1 : (rank == 2 ? 0.8 : 0.6),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: brightness == Brightness.light ? AppColors.accentColorLight : Colors.amberAccent,
              border: Border.all(color: Colors.black12, width: 2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(7.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPaddings.padding_8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '#$rank',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isUser ?? false)
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: AppPaddings.padding_4),
                        Text(
                          AppStrings.ownCard,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppPaddings.padding_8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      username,
                      style: TextStyle(
                        color: brightness == Brightness.light ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: AppPaddings.padding_4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${totalPoints.toString()} Points',
                      style: TextStyle(
                        color: brightness == Brightness.light ? Colors.white : Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
