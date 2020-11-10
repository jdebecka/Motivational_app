import 'package:core_values_app/main.dart';
import 'package:core_values_app/ui/screen_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/favourite/favourite_cubit.dart';
import 'cubits/user_core_values/user_values_cubit.dart';

class GlobalProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => UserValuesCubit()),
      BlocProvider(create: (context) => FavouriteCubit())
    ], child: MyApp());
  }
}
