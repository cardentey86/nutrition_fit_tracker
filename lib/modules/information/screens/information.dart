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
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                'Esta app es tu compañero ideal para alcanzar tus metas de salud y bienestar a través de un enfoque holístico en la gestión de la alimentación y el seguimiento del acondicionamiento físico. Nuestra aplicación está diseñada para ayudarte a llevar un control detallado de tus hábitos alimenticios y a calcular índices esenciales que te permitirán entender mejor tu composición corporal y optimizar tu nutrición. \n\n',
                          ),
                          TextSpan(
                            text:
                                'No solo aprenderás a gestionar tus alimentos de manera efectiva, sino que también obtendrás un entendimiento más profundo de cómo tu dieta y tu entrenamiento impactan en tu salud general. Ya seas un principiante en el mundo del fitness o un atleta experimentado, nuestra aplicación proporciona las herramientas necesarias para empoderarte en tu viaje hacia un estilo de vida más saludable. \n\n',
                          ),
                          TextSpan(
                            text: 'Principales características: \n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Gestión de alimentos: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Ingresa y lleva un seguimiento de tus comidas diarias con una amplia base de datos de alimentos. Accede a información nutricional precisa que te ayudará a tomar decisiones informadas sobre lo que comes. \n\n',
                          ),
                          TextSpan(
                            text: 'Cálculo de macronutrientes: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'La aplicación te permite calcular y ajustar tu consumo diario de macronutrientes (carbohidratos, proteínas y grasas) según tus objetivos específicos, ya sea para perder peso, ganar músculo o mantener una alimentación equilibrada. \n\n',
                          ),
                          TextSpan(
                            text: 'Cálculo de porcentaje de grasa y músculo: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Utiliza herramientas para estimar tu porcentaje de grasa corporal y músculo magro, lo que te permite tener una visión más clara de tu composición corporal y ajustar tu dieta y entrenamiento en consecuencia. \n\n',
                          ),
                          TextSpan(
                            text: 'Tasa Metabólica Basal (TMB)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Calcula tu TMB para determinar cuántas calorías necesita tu cuerpo en reposo, lo que te ayudará a establecer un plan de alimentación personalizado y efectivo. \n\n',
                          ),
                          TextSpan(
                            text: 'Predicción de ganancia muscular: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'La predicción genética de la ganancia muscular es clave para personalizar el entrenamiento, estableciendo metas realistas y optimizando la nutrición según la predisposición individual. Esto no solo maximiza la eficiencia del crecimiento muscular y el rendimiento deportivo, sino que también ayuda a prevenir lesiones y a mantener la motivación a largo plazo, impulsando la investigación en estrategias de entrenamiento y nutrición más efectivas. \n\n',
                          ),
                          TextSpan(
                            text: 'Medidas estéticas: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Las medidas estéticas del cuerpo son importantes porque reflejan la percepción de la imagen corporal, influyendo en la autoestima, la confianza y el bienestar psicológico. Alcanzar ciertos estándares estéticos puede mejorar la satisfacción personal, fomentar hábitos saludables como el ejercicio y una dieta equilibrada, y promover interacciones sociales positivas. Aunque es crucial equilibrar la estética con la salud y evitar la obsesión, las medidas estéticas pueden servir como una motivación para el autocuidado y la búsqueda de una mejor calidad de vida. \n\n',
                          ),
                          TextSpan(
                            text: 'Objetivos Personalizados: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Establece metas de nutrición y entrenamiento adaptadas a tus necesidades individuales, y monitoriza tu progreso a lo largo del tiempo. La aplicación te enviará recordatorios y motivación para mantenerte enfocado en tus objetivos. \n\n',
                          ),
                          TextSpan(
                            text: 'Informes: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Genera informes sobre tu ingesta diaria, el progreso en tu composición corporal y tus hábitos alimenticios, brindándote información valiosa para realizar ajustes y mejorar tu enfoque hacia la salud. \n\n',
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
