import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_reports_container.dart';
import '../../../../../core/utils/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Safe Return',
          style: Styles.textStyle32,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Stack(
            children: [
              Positioned(
                right: (MediaQuery.of(context).size.width - 300) / 2,
                left: (MediaQuery.of(context).size.width - 300) / 2,
                top: 40,
                child: CustomReportsContainer(
                  onTap: () => context.goNamed('missingPersonFormView'),
                  // onTap: () =>
                  //     GoRouter.of(context).push('/missingPersonFormView'),
                  image: 'assets/homeViewPhotos/missingPersonReport.svg',
                  text: 'Report of a missing person',
                ),
              ),
              Positioned(
                right: (MediaQuery.of(context).size.width - 310) / 2,
                left: (MediaQuery.of(context).size.width - 310) / 2,
                top: 300,
                child: CustomReportsContainer(
                  onTap: () => context.goNamed('findPersonFormView'),
                  image: 'assets/homeViewPhotos/findPersonReport.svg',
                  text: 'Report of a missing person found',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
