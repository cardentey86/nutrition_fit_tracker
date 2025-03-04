import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Información',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/img/logo_info_nft_blue.svg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            const Text('Version 1.0'),
            const SizedBox(height: 8),
            ExpansionTile(
              title: const Text('Acerca de NFT'),
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
                            text: 'Nutrition Fitness Tracker',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ' es tu compañero ideal para alcanzar tus metas de salud y bienestar a través de un enfoque holístico en la gestión de la alimentación y el seguimiento del acondicionamiento físico. Nuestra aplicación está diseñada para ayudarte a llevar un control detallado de tus hábitos alimenticios y a calcular índices esenciales que te permitirán entender mejor tu composición corporal y optimizar tu nutrición. \n\n',
                          ),
                          TextSpan(
                            text:
                                'Con Nutrition Fitness Tracker, no solo aprenderás a gestionar tus alimentos de manera efectiva, sino que también obtendrás un entendimiento más profundo de cómo tu dieta y tu entrenamiento impactan en tu salud general. Ya seas un principiante en el mundo del fitness o un atleta experimentado, nuestra aplicación proporciona las herramientas necesarias para empoderarte en tu viaje hacia un estilo de vida más saludable. \n\n',
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
                            text: 'Objetivos Personalizados',
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
              title: const Text('Cómo tomar las medidas personales'),
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
                            text: 'Pecho: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica por debajo de las axilas a la altura de los pezones y mantenerse relajado \n\n',
                          ),
                          TextSpan(
                            text: 'Biceps: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica alrededor del centro del biceps relajado con el brazo pegado al cuerpo \n\n',
                          ),
                          TextSpan(
                            text: 'Antebrazo: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica alrededor del antebrazo relajado por la parte más gruesa \n\n',
                          ),
                          TextSpan(
                            text: 'Cintura: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica alrededor de la cintura a por sobre el hombligo \n\n',
                          ),
                          TextSpan(
                            text: 'Cadera: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica alrededor de la cadera a la altura de la pelvis \n\n',
                          ),
                          TextSpan(
                            text: 'Muslo: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica alrededor del centro del muslo relajado \n\n',
                          ),
                          TextSpan(
                            text: 'Gemelos: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Pasar la cinta métrica alrededor del gemelo por la parte más gruesa \n\n',
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
            ExpansionTile(
              title: const Text('Indices personales'),
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
                            text: 'Indice de Masa Corporal: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'El Índice de Masa Corporal (IMC) es una herramienta útil para evaluar la relación entre el peso y la altura de una persona, proporcionando una estimación de la grasa corporal \n\n',
                          ),
                          TextSpan(
                            text: 'Ritmo máximo cardiaco: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'El ritmo máximo cardíaco (RMC) es la frecuencia cardíaca más alta que una persona puede alcanzar durante actividad física intensa \n\n',
                          ),
                          TextSpan(
                            text: 'Porcentaje de grasa corporal (PGC): ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Calcular el porcentaje de grasa corporal es importante para evaluar la composición corporal y la salud general de una persona. Existen diferentes métodos para estimar este porcentaje. Fórmula de Navy: Utiliza medidas de la circunferencia de la cintura y el cuello (y de las caderas para las mujeres) junto con la altura para estimar el porcentaje de grasa corporal. Fórmula de YMCA: Se basa en la altura y el peso para estimar el porcentaje de grasa corporal, aunque es menos precisa que otras metodologías. El cálculo del porcentaje de grasa corporal proporciona una visión más completa de la salud y la condición física que solo el peso corporal. Sin embargo, es recomendable combinar estos métodos con otras medidas de salud para obtener una evaluación más precisa y holística. \n\n',
                          ),
                          TextSpan(
                            text: 'Porcentaje de músculo magro (PMM): ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'El cálculo del porcentaje de músculo magro es útil para obtener una comprensión más detallada de la composición corporal de una persona. Este porcentaje se refiere a la cantidad de masa muscular en relación con el peso total del cuerpo, excluyendo la grasa.  \n\n',
                          ),
                          TextSpan(
                            text: 'Tasa metabólica basal (TMB): ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'La tasa metabólica basal (TMB) es la cantidad de energía que el cuerpo gasta en reposo para mantener funciones vitales como la respiración, circulación sanguínea, regulación de la temperatura corporal y funcionamiento de los órganos. Es un indicador clave de las necesidades energéticas del cuerpo en reposo y sirve como base para personalizar entrenamientos y planes de nutrición. Con una comprensión adecuada de la TMB, los atletas y las personas interesadas en mejorar su salud pueden optimizar su rendimiento y alcanzar sus objetivos de manera más efectiva y saludable \n\n',
                          ),
                          TextSpan(
                            text: 'Predicción de ganancia muscular (PGM): ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Predecir la ganancia muscular según la genética es importante por varias razones, tanto para atletas como para individuos que buscan mejorar su composición corporal. La genética desempeña un papel fundamental en la capacidad de una persona para ganar músculo y, al reconocer su influencia, se puede optimizar el entrenamiento, la nutrición y la recuperación. Esto no solo mejora los resultados, sino que también apoya la salud y el bienestar general, brindando un enfoque más consciente y personalizado al desarrollo físico. \n\n',
                          ),
                          TextSpan(
                            text: 'Consumo diario de macronutrientes (CDM): ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Conocer cómo debe ser el consumo diario de macronutrientes es fundamental para mantener una salud óptima, alcanzar objetivos de fitness y mejorar el rendimiento físico. Esto implica no solo un conocimiento detallado sobre los macronutrientes, sino también una comprensión de cómo interactúan en el cuerpo y cómo influyen en nuestro día a día. Al final, una alimentación bien planificada y equilibrada es clave para lograr un estilo de vida saludable y sostenible. \n\n',
                          ),
                          TextSpan(
                            text: 'Medidas esteticamente ideales (MI): ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Conocer las medidas estéticamente ideales para las diferentes partes del cuerpo puede tener varias implicaciones, tanto en términos de salud como de bienestar emocional y autoestima, guiar el desarrollo de un plan de entrenamiento y nutrición, y fomentar la autoaceptación. Sin embargo, es importante abordar este conocimiento con una mentalidad equilibrada, considerando la salud y el bienestar personal por encima de los ideales sociales o culturales. La clave es encontrar un enfoque que promueva no solo la apariencia, sino también la salud y la felicidad personal. \n\n',
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),

            // Puedes añadir más ExpansionTile según sea necesario
          ],
        ),
      ),
    );
  }
}
