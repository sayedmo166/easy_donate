import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/presentation/views_model/auth__cubit.dart';
import '../../view_model/add_item_cubit.dart';
import '../../view_model/add_item_state.dart';
import 'add_photo.dart';
import 'custom_select_field.dart';
import 'text_filed.dart';

class AddItemViewBody extends StatefulWidget {
  const AddItemViewBody({super.key});

  @override
  State<AddItemViewBody> createState() => _AddItemViewBodyState();
}

class _AddItemViewBodyState extends State<AddItemViewBody> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedItemType;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listener: (context, state) {
        if (state is ItemUploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم رفع العنصر بنجاح!')),
          );
          setState(() {
            addressController.clear();
            numberController.clear();
            selectedItemType = null;
          });
        } else if (state is ItemError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ItemUploading) {
          return const Center(child: CircularProgressIndicator(backgroundColor: Colors.transparent));
        }
        return _buildForm();
      },
    );
  }

  Widget _buildForm() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFF5F5F5)],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const AddPhoto(),
                const SizedBox(height: 30),
                CustomSelectField(
                  onChanged: (value) {
                    setState(() {
                      selectedItemType = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                TextFieldForm(
                  icon: Icons.add_home_rounded,
                  taskController: addressController,
                  hint: 'العنوان',
                  validate: (value) {
                    if (value!.trim().isEmpty) {
                      return 'يجب إدخال العنوان';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFieldForm(
                  taskController: numberController,
                  hint: 'رقم الموبايل',
                  validate: (value) {
                    if (value!.trim().isEmpty) {
                      return 'يجب إدخال رقم الموبايل';
                    }
                    return null;
                  },
                  icon: Icons.phone_callback_rounded,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final cubit = context.read<ItemCubit>();
                      final currentUser = context.read<AuthCubit>().currentUser;

                      if (currentUser != null && selectedItemType != null) {
                        cubit.uploadItem(
                          address: addressController.text.trim(),
                          phone: numberController.text.trim(),
                          itemType: selectedItemType!,
                          userId: currentUser.userId,
                          userName: currentUser.name,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('لم يتم العثور على المستخدم أو لم يتم اختيار النوع.')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF6A7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'تسجيل',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
