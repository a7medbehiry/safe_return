import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

PersistentBottomSheetController<dynamic> customAboutUsBottomSheet(BuildContext context) {
    return showBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  context: context,
                  builder: (context) {
                    return  SizedBox(
      height: 640,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          const CircleAvatar(
            backgroundColor: kThirdColor,
            radius: 57,
            child: CircleAvatar(
              backgroundColor: Color(0xffF7F2F9),
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
          const SizedBox(
            height: 20,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'the leading mobile application that is dedicated to',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'finding lost people in public places or on the streets',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'and expediting the search and reunification process.',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Our smart system leverages advanced technologies',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'to provide a seamless and efficient experience for',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                ' both finders and the families of the lost individuals.',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Thank you for choosing Safe Return and joining us',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'on our mission to ensure the safe return of lost',
                style: Styles.textStyleMed13,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'individuals and the peace of mind of their loved ones',
                style: Styles.textStyleMed13,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
        ],
      ),
    );
                  },
                );
  }

