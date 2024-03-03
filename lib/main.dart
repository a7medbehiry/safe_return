import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_return/Features/signUpView/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:safe_return/core/utils/app_router.dart';
import 'Features/loginView/manager/login_cubit/login_cubit.dart';

void main() {
  runApp(const SafeReturnApp());
}

class SafeReturnApp extends StatelessWidget {
  const SafeReturnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
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
