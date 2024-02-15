import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            SvgPicture.asset('assets/aboutUsViewPhotos/about.svg'),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'About Us',
              style: Styles.textStyleMed22,
            ),
          ],
        ),
        SizedBox(
          height: 570,
          child: Stack(
            children: [
              Positioned(
                left: 48,
                top: 100,
                child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: kThirdColor,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Welcome to Safe Return',
                      style: Styles.textStyleSemi15,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 140,
                top: 20,
                child: CircleAvatar(
                  backgroundColor: kThirdColor,
                  radius: 57,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 55,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(
                            'assets/aboutUsViewPhotos/aboutUsAnimation.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 200,
                child: Container(
                  height: 350,
                  width: 355,
                  decoration: const BoxDecoration(
                    color: kSecondColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'the leading mobile application that is dedicated to',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'finding lost people in public places or on the streets',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'and expediting the search and reunification process.',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Our smart system leverages advanced technologies',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'to provide a seamless and efficient experience for',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          ' both finders and the families of the lost individuals.',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Thank you for choosing Safe Return and joining us',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'on our mission to ensure the safe return of lost',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'individuals and the peace of mind of their loved ones',
                          style: Styles.textStyleMed12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/aboutUsViewPhotos/team.svg'),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'The Safe Return Team',
                style: Styles.textStyleSemi16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
