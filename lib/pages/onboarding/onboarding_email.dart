import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tiki/authentications_bloc/cubits/signup_cubit.dart';
import 'package:tiki/widgets/custombtn.dart';
import 'package:tiki/widgets/header.dart';

import '../../widgets/custom_textfield.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('STEP 1 OF 6',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 7),
                  const CustomTextHeader(text: 'Choose a Unique Username'),
                  const SizedBox(height: 7),
                  CustomTextField(
                    hint: 'John Doe',
                    icon: EvaIcons.person,
                    onChanged: (value) {
                      context.read<SignupCubit>().usernamechanged(value);
                      print(state.username);
                    },
                  ),
                  const SizedBox(height: 30),
                  const CustomTextHeader(text: 'What\'s Your Email Address?'),
                  const SizedBox(height: 7),
                  CustomTextField(
                    hint: 'JohnDoe@gmail.com',
                    icon: Icons.email,
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                      print(state.email);
                    },
                  ),
                  const SizedBox(height: 30),
                  const CustomTextHeader(text: 'Choose a Password'),
                  const SizedBox(height: 7),
                  CustomTextField(
                    icon: EvaIcons.lock,
                    hint: '********',
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                      print(state.password);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).backgroundColor,
                  ),
                  SizedBox(height: 10),
                  CustomButton(tabController: tabController, text: 'NEXT STEP'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
