import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/email_paswword_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/updae_image_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_pickImage_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

class SetProfileViewBody extends StatefulWidget {
  const SetProfileViewBody({super.key});

  @override
  State<SetProfileViewBody> createState() => _SetProfileViewBodyState();
}

class _SetProfileViewBodyState extends State<SetProfileViewBody> {
  File? selectedImage;
  String? selectedImagePath;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              child: Row(
                children: [
                  const CustomAppBar(),
                  SizedBox(
                    width: SizeConfig.screenwidth! * 0.26,
                  ),
                  Text(
                    'Profile',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Center(
              child: CustomPickImageButton(
                child: selectedImage == null
                    ? null
                    : Image.file(selectedImage!, fit: BoxFit.fill),
                onTap: () async {
                  await pickImageFromGallery();
                  setState(() {
                    selectedImagePath = selectedImage?.path ?? '';
                  });
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: CustomTextField(
                  onChanged: (value) {
                    UserCubit.user.fullName = value;
                  },
                  hintText: 'Full name'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: CustomTextField(
                  onChanged: (value) {
                    UserCubit.user.adress = value;
                  },
                  hintText: 'Adress'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: CustomTextField(
                  onChanged: (value) {
                    UserCubit.user.city = value;
                  },
                  hintText: 'City'),
            ),
            SizedBox(
              height: SizeConfig.screenhieght! * 0.28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                          onPressed: () {},
                          title: Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          backgroundColor: Colors.white),
                    ),
                    SizedBox(
                      width: SizeConfig.defaultSize! * 2,
                    ),
                    Expanded(
                      child: BlocListener<UpdaeImageCubit, UpdaeImageState>(
                        listener: (context, state) async {
                          if (state is UpdateImageSuccess) {
                            UserCubit.user.imageUrl = state.imageUrl;

                            await BlocProvider.of<EmailPaswwordCubit>(context)
                                .addUserToFireStore(
                                    user: UserCubit.user,
                                    uid: UserCubit.user.uId ?? 'err');
                          }
                        },
                        child: CustomButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                await BlocProvider.of<UpdaeImageCubit>(context)
                                    .uploadDriverImageToFirebase(
                                        imagePath: selectedImagePath ?? '');

                                var newuserbox = Hive.box<UserModel>(kUserBox);
                                if (newuserbox.isNotEmpty) {
                                  newuserbox.deleteAt(0);
                                }

                                await newuserbox.add(UserCubit.user);
                                GoRouter.of(context)
                                    .pushReplacement(AppRouter.kHomeView);
                              }
                            },
                            title: const Text('Save'),
                            backgroundColor: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedIamge =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedIamge == null) return;
    setState(() {
      selectedImage = File(returnedIamge.path);
    });
  }
}
