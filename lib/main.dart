import 'package:bi_ufcg/service/data/data.dart';
import 'package:bi_ufcg/repositories/auth/auth_repository.dart';
import 'package:bi_ufcg/repositories/auth/auth_repository_impl.dart';
import 'package:bi_ufcg/screen/auth/login/login_route.dart';
import 'package:bi_ufcg/screen/home/home_page.dart';
import 'package:bi_ufcg/screen/home/home_route.dart';
import 'package:bi_ufcg/screen/splash/view/splash_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:provider/provider.dart';

import 'core/config/env/env.dart';
import 'core/rest/dio_custom.dart';
import 'resource/app_colors.dart';

void main() async {
  //await Env.i.load();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterGetItApplicationBinding(
      bindingsBuilder: () => [
        Bind.lazySingleton<CustomDio>((i) => CustomDio()),
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(dio: i())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Admin Panel',
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.purpleDark,
              primarySwatch: Colors.blue,
              canvasColor: AppColors.purpleLight),
          routes: {
            '/': (_) => const SplashRoute(),
            '/login': (context) => const LoginRoute(),
            '/home': (context) => const HomeRoute(),
          }),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // Classe Data que extende ChangeNotifier para gerenciar o estado
// class Data extends ChangeNotifier {
//   int _value = 0;

//   int get value => _value;

//   void updateValue() {
//     _value++;
//     notifyListeners(); // Notifica os listeners sobre mudanças no estado
//   }
// }

// void main() {
//   runApp(
//     // Provedor de estado que disponibiliza a classe Data para todo o app
//     ChangeNotifierProvider(
//       create: (context) => Data(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Provider Example',
//       home: Home(),
//     );
//   }
// }

// // Classe Home que exibe o botão e a classe Filho
// class Home extends StatelessWidget {
//   Home({
//     super.key,
//   });

//   Data data = Data();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Provider Example')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Filho(), // Classe Filho que exibe o valor atual
//           ElevatedButton(
//             onPressed: () {
//               // Atualiza o valor na classe Data
//               //  context.read<Data>().updateValue();
//               data.updateValue();
//             },
//             child: const Text('Atualizar Valor'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Classe Filho que exibe o valor armazenado em Data
// class Filho extends StatelessWidget {
//   const Filho({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<Data>(context); // Escuta mudanças automaticamente

//     return data.value == 0
//         ? Text(
//             'Valor: ${data.value}',
//             style: const TextStyle(fontSize: 24),
//           )
//         : Text(
//             'Valor: ${data.value}',
//             style: const TextStyle(fontSize: 24, color: Colors.red),
//           );
//   }
// }
