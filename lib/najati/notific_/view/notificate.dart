import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../../month.dart';
import '../bloc/notific_bloc.dart';

// import 'core/widgets/textfield_common.dart';
// import 'main.dart';

class Notifications extends StatelessWidget {
  Notifications(this.nameChild, this.imageChild);
  String nameChild;
  String? imageChild;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificBloc()..add(GetNotific()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocConsumer<NotificBloc, NotificState>(
              listener: (context, state) {
                if (state is NotificEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(' لا يوجد لديك إشعارات')),
                  );
                }
                // You can add other side effects here.
              },
              builder: (context, state) {
                if (state is NotificInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotificEmpty) {
                  return const Center(child: Text(""));
                } else if (state is NotificSuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: screenW * 0.88,
                        height: screenH * 0.08,
                        // decoration: DecorationField.decorationContainer,
                        child: ListTile(
                          title: Text(
                            state.notificate[index].data.title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: const Text(
                            "",
                            // "ل بالصلاة لمدة شهر"
                            //,
                            //  style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          trailing: Container(
                            height: screenH * 0.15,
                            width: screenW * 0.09,
                            // fit: BoxFit.contain,
                            child: const Icon(Icons.stacked_line_chart_rounded),
                          ),
                          leading: Text(
                            state.notificate[index].date,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.notificate.length,
                  );
                } else if (state is NotificFailed) {
                  return const Center(child: Text('لا يوجد اتصال بالانترنت'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
