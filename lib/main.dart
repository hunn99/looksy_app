// import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/data/datasources/remote_datasources/auth_remote_datasources.dart';
import 'package:looksy_app/data/datasources/remote_datasources/hairstyle_remote_datasources.dart';
import 'package:looksy_app/data/datasources/remote_datasources/order_remote_datasources.dart';
import 'package:looksy_app/data/datasources/remote_datasources/history_remote_datasources.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:looksy_app/presentation/bloc/hairstyle/hairstyle_bloc.dart';
import 'package:looksy_app/presentation/bloc/order/order_bloc.dart';
import 'package:looksy_app/presentation/bloc/scan/scan_bloc.dart';
import 'package:looksy_app/presentation/router/routes.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

import 'data/datasources/remote_datasources/scan_remote_datasources.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authServices: AuthServices()),
        ),
        BlocProvider(
            create: (context) => OrderBloc(
                  orderServices: OrderServices(),
                  historyRemoteDataSource: HistoryRemoteDataSource(),
                )),
        BlocProvider(
          create: (context) => ScanBloc(scanServices: ScanServices()),
        ),
        BlocProvider(
          create: (context) => HairstyleBloc(
            hairstyleRemoteDatasource: HairstyleRemoteDatasources(),
          )..add(const GetHairstyleEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: getRoute(),
      ),
    );
  }
}
