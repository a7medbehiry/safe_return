import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:safe_return/Features/profileView/data/models/user_model/user_model.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/app_router.dart';
import 'Features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'Features/profileView/presentation/manager/user_cubit/user_cubit.dart';
import 'core/utils/functions/simple_bloc_observer.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(kUserBox);

  runApp(const SafeReturnApp());
}


class SafeReturnApp extends StatelessWidget {
  const SafeReturnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      ),
    );
  }
}
