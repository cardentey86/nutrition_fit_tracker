import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'information.title'.tr(),
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/img/logo_info_nft_blue.svg',
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.cover,
            ),
            const Text('Version 1.0'),
            const SizedBox(height: 8),
            ExpansionTile(
              title: Text('information.about'.tr()),
              children: [
                ListTile(
                    title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                '${'information.aboutSection.desc1'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.desc2'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.title'.tr()}: \n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section1Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section1Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section2Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section2Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section3Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section3Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: 'information.aboutSection.section4Title'.tr(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section4Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section5Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section5Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section6Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section6Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section7Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section7Desc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section8Title'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${'information.aboutSection.section8Desc'.tr()} \n\n',
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
            ExpansionTile(
              title: Text('information.howMeasurements'.tr()),
              children: [
                ListTile(
                    title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${'information.neck'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.neckDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.chest'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.chestDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.biceps'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.bicepsDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.forearm'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.forearmDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.waist'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.waistDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.hip'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.hipDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.thigh'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.thighDesc'.tr()} \n\n',
                          ),
                          TextSpan(
                            text: '${'information.calf'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.calfDesc'.tr()} \n\n',
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
            ExpansionTile(
              title: Text('information.personalIndex'.tr()),
              children: [
                ListTile(
                    title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${'information.imc'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.imcDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.rmc'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.rmcDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.pgc'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.pgcDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.pmm'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.pmmDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.tmb'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.tmbDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.pgm'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.pgmDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.cdm'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.cdmDesc'.tr()}\n\n',
                          ),
                          TextSpan(
                            text: '${'information.mei'.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${'information.meiDesc'.tr()}\n\n',
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
