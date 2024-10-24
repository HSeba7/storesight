import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/components/loading_widget.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/view_models/app_cubit/cubit.dart';
import 'package:storesight/view_models/app_cubit/states.dart';
import 'package:storesight/view_models/auth_cubit/auth_cubit.dart';
import 'package:storesight/view_models/client_cubit/cubit.dart';
import 'package:storesight/view_models/forget_cubit/cubit.dart';
import 'package:storesight/view_models/home_cubit/home_cubit.dart';
import 'package:storesight/view_models/scan_cubit/scan_cubit.dart';
import 'package:storesight/views/auth_views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClientCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ForgetPasswordCubit()),
        BlocProvider(create: (_) => AppCubit()..getUser()),
        BlocProvider(create: (_) => HomeCubit()..getProducts()),
        BlocProvider(create: (_) => ScanCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: ConditionalBuilder(
              condition: state is! GetUserDataLoadingState,
              builder: (context) => cubit.currentView() ?? const LoginView(),
              fallback: (context) => const LoadingView(),
            ),
          );
        },
      ),
    );
  }
}
