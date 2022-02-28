import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tiki/authentications_bloc/cubits/signup_cubit.dart';
import 'package:tiki/widgets/custom_textfield.dart';
import 'package:tiki/widgets/custombtn.dart';
import 'package:tiki/widgets/header.dart';

class Demo extends StatefulWidget {
  final TabController tabController;

  const Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool selected = false;
  String? currentSelectedValue;
  String? currentSelectGender;
  List ageRange = ["15-20", "20-25", "25-30", "30-35", "35-40", "40 and above"];
  List gender = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('STEP 2 OF 6',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 7),
                  const CustomTextHeader(text: 'What\'s Your Gender?'),
                  const SizedBox(height: 20),
                  FormField(builder: (FormFieldState state) {
                    return InputDecorator(
                      expands: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withAlpha(60),
                          labelStyle: GoogleFonts.poppins(color: Colors.black),
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintStyle: GoogleFonts.poppins(color: Colors.black),
                          border: InputBorder.none),
                      isEmpty: currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(
                            'Select your Gender',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 12,
                            ),
                          ),
                          value: currentSelectedValue,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              currentSelectedValue = newValue;
                              state.didChange(newValue);
                              selected = true;
                              context
                                  .read<SignupCubit>()
                                  .genderChanged(newValue!);
                            });
                          },
                          items: gender.map((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 100),
                  const CustomTextHeader(text: 'What\'s Your Age?'),
                  CustomTextField(
                    icon: Icons.percent,
                    hint: 'ENTER YOUR AGE',
                    onChanged: (value) {
                      context.read<SignupCubit>().ageChanged(value);
                      print(state.age);
                    },
                    // controller: controller,
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 3,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).backgroundColor,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      tabController: widget.tabController, text: 'NEXT STEP'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
