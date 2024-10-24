import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/view_models/client_cubit/states.dart';
import 'package:storesight/views/client_views/home_view.dart';
import 'package:storesight/views/client_views/profile_view.dart';

class ClientCubit extends Cubit<ClientStates> {
  ClientCubit() : super(ClientStates());
  static ClientCubit get(context) => BlocProvider.of(context);

  int index = 0;

  List<Widget> views = [
    const HomeView(),
    const ProfileView(),
  ];

  void changeIndex(int value) {
    index = value;
    emit(ClientChangeState(index: index));
  }
}
