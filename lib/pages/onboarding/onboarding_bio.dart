import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tiki/authentications_bloc/cubits/signup_cubit.dart';
import 'package:tiki/widgets/custom_text_container.dart';
import 'package:tiki/widgets/custom_textfield.dart';
import 'package:tiki/widgets/custombtn.dart';
import 'package:tiki/widgets/header.dart';

class Bio extends StatefulWidget {
  final TabController tabController;

  const Bio({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  bool isSelect = false;
  final int isSelected = 0;
  final List seletctedInterest = [];
  final List interests = const [
    'Coding',
    'Design',
    'Music',
    'Dancing',
    'Reading',
    'Cooking',
    'Traveling',
    'Photography',
    'Fashion',
    'Art',
    'Sports',
    'Gaming',
    'Fitness',
    'Nature',
    'Technology',
    'Writing',
    'Hiking',
  ];
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return SingleChildScrollView(
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('STEP 4 OF 5',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(text: 'Describe Yourself'),
                    const SizedBox(height: 10),
                    CustomTextField(
                      icon: Icons.person_add,
                      hint: 'Software Engineer at Google',
                      onChanged: (value) {
                        context.read<SignupCubit>().biochange(value);
                        print(state.bio);
                      },
                      // controller: controller,
                    ),
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTextHeader(
                            text: 'Selet 3 or more interests'),
                        Text(
                          '${seletctedInterest.length}/${interests.length}',
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.2,
                      width: double.infinity,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 21 / 11,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3,
                          children: interests.map((interest) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomTextContainer(
                                  isSelected:
                                      seletctedInterest.contains(interest)
                                          ? true
                                          : false,
                                  onPressed: () {
                                    setState(
                                      () {
                                        if (seletctedInterest
                                            .contains(interest)) {
                                          seletctedInterest.remove(interest);
                                        } else {
                                          seletctedInterest.add(interest);
                                          context
                                              .read<SignupCubit>()
                                              .interestSelected(
                                                  seletctedInterest);
                                        }
                                      },
                                    );
                                    print(state.interest);
                                  },
                                  text: interest),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 5,
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
      ),
    );
  }
}
