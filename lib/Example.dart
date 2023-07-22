import 'package:balance/ConcreteCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance/constants.dart';

class TrainerTrainee extends StatelessWidget {
  final void Function(ConcreteCubit<bool>) ontap;

  const TrainerTrainee({Key? key, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConcreteCubit<bool> trainerOrTrainee = ConcreteCubit<bool>(true);

    return BlocBuilder<ConcreteCubit<bool>, bool>(
        bloc: trainerOrTrainee,
        builder: (context, selection) {
          return GestureDetector(
            child: Center(
              child: Container(
                height: 300,
                width: 300,
                color: strawberry,
                child: Center(child: Text(trainerOrTrainee.toString())),
              ),
            ),
            onTap: () {
              ontap(trainerOrTrainee);
            },
          );
        });
  }
}
