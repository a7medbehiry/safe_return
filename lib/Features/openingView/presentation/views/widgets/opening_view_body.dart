import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_shield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/widgets/custom_button.dart';

class OpeningViewBody extends StatefulWidget {
  const OpeningViewBody({
    super.key,
  });

  @override
  State<OpeningViewBody> createState() => _OpeningViewBodyState();
}

class _OpeningViewBodyState extends State<OpeningViewBody> {
  String? email;

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  Future getValidationData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var obtainEmail = preferences.getString('email');
    setState(() {
      email = obtainEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.65,
            ),
            Positioned(
              left: -100,
              top: -60,
              child: SvgPicture.asset(
                'assets/openingViewPhotos/shape.svg',
              ),
            ),
            const Positioned(
              left: 135,
              top: 130,
              child: Text(
                'Safe Return',
                style: Styles.textStyle24,
              ),
            ),
          ],
        ),
        SvgPicture.asset(
          'assets/openingViewPhotos/openingView.svg',
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Bring Lost Smiles Home & Reunite Hearts',
          style: Styles.textStyle12,
        ),
        const SizedBox(
          height: 50,
        ),
        CustomButton(
          onTap: () async {
            getValidationData().whenComplete(
              () => email == null
                  ? GoRouter.of(context).push('/loginView')
                  : GoRouter.of(context).push('/homeView'),
            );
          },
          width: 200,
          height: 45,
          text: Text(
            'let\'s get started',
            style: Styles.textStyleSemi16.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7.3,
            ),
            Positioned(
              right: 50,
              bottom: -30,
              child: SvgPicture.asset(
                'assets/openingViewPhotos/circle.svg',
              ),
            ),
            const Positioned(
              left: 30,
              bottom: 20,
              child: CustomShield(),
            ),
          ],
        ),
      ],
    );
  }
}
