import 'package:flutter/material.dart';
import 'package:safe_return/core/utils/styles.dart';

Future<PersistentBottomSheetController> customContactUsBottomSheet(
    BuildContext context) async {
  return showBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    context: context,
    builder: (context) {
      return SizedBox(
        height: 640,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                'First Place',
                style: Styles.textStyleMed15,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Haram - 7 Haj Moussa St. off Yehia Shaheen St.',
                style: Styles.textStyleMed13,
              ),
              const Text(
                'in front of Tikka Al Taawun Restaurant',
                style: Styles.textStyleMed13,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 270),
                child: Text(
                  '0233831185',
                  style: Styles.textStyleMed13.copyWith(
                    color: const Color(0xff0000FF),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff0000FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 270, top: 5),
                child: Text(
                  '0233831189',
                  style: Styles.textStyleMed13.copyWith(
                    color: const Color(0xff0000FF),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff0000FF),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                width: 350,
                child: Divider(
                  thickness: 1,
                  color: Color(0xffA5A5A5),
                  indent: 0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Second Place',
                style: Styles.textStyleMed15,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Al-Gish Street (formerly Al-Bahr), corner of Taha',
                style: Styles.textStyleMed13,
              ),
              const Text(
                'Al-Hakim Zahana Tower next to Sednawy Tanta',
                style: Styles.textStyleMed13,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260),
                child: Text(
                  '04-03336016',
                  style: Styles.textStyleMed13.copyWith(
                    color: const Color(0xff0000FF),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff0000FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260, top: 5),
                child: Text(
                  '04-03336089',
                  style: Styles.textStyleMed13.copyWith(
                    color: const Color(0xff0000FF),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff0000FF),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                width: 350,
                child: Divider(
                  thickness: 1,
                  color: Color(0xffA5A5A5),
                  indent: 0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Third Place',
                style: Styles.textStyleMed15,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '8 El Horreya Road - Ganaklis - in front of the Faculty',
                style: Styles.textStyleMed13,
              ),
              const Text(
                ' of Fine Arts - Alexandria',
                style: Styles.textStyleMed13,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260),
                child: Text(
                  '03-5849702',
                  style: Styles.textStyleMed13.copyWith(
                    color: const Color(0xff0000FF),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff0000FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260, top: 5),
                child: Text(
                  '03-5849703',
                  style: Styles.textStyleMed13.copyWith(
                    color: const Color(0xff0000FF),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff0000FF),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
