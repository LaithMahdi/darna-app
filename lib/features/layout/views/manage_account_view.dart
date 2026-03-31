import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/config.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/custom_dropdown.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import '../../../shared/text/sub_label.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ManageAccountView extends StatefulWidget {
  const ManageAccountView({super.key});

  @override
  State<ManageAccountView> createState() => _ManageAccountViewState();
}

class _ManageAccountViewState extends State<ManageAccountView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ValueNotifier<String?> _selectedGender = ValueNotifier<String?>(null);
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _selectedGender.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _emailController.text = user.email ?? '';
    _fullNameController.text = user.displayName ?? '';

    try {
      final doc = await FirebaseFirestore.instance
          .collection(Config.userCollection)
          .doc(user.uid)
          .get();
      final data = doc.data();
      final fullName = (data?['fullName'] ?? '') as String;
      final phoneNumber = (data?['phoneNumber'] ?? '') as String;
      final gender = (data?['gender'] ?? '') as String;

      if (fullName.trim().isNotEmpty) {
        _fullNameController.text = fullName;
      }
      if (phoneNumber.trim().isNotEmpty) {
        _phoneNumberController.text = phoneNumber;
      }
      if (gender.trim().isNotEmpty) {
        _selectedGender.value = gender;
      }
    } catch (_) {}

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveProfile() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _isSaving) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showToast(context, 'You must login first.', isError: true);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final fullName = _fullNameController.text.trim();
      final phoneNumber = _phoneNumberController.text.trim();
      final gender = _selectedGender.value;
      await user.updateDisplayName(fullName);

      await FirebaseFirestore.instance
          .collection(Config.userCollection)
          .doc(user.uid)
          .set({
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'gender': gender,
          }, SetOptions(merge: true));

      if (!mounted) return;
      showToast(context, 'Account updated successfully!');
    } on FirebaseException catch (e) {
      if (!mounted) return;
      showToast(
        context,
        e.message ?? 'Failed to update account.',
        isError: true,
      );
    } catch (_) {
      if (!mounted) return;
      showToast(context, 'Failed to update account.', isError: true);
    } finally {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context) ? CustomBackButton() : null,
        title: Text('Manage Account'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: Config.defaultPadding,
              children: [
                SubLabel(
                  text:
                      'Update your account details. These details are visible to your roommates inside colocations.',
                ),
                VerticalSpacer(20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(label: 'Full Name'),
                      Input(
                        hintText: 'E.g: Mahdi Bouzid',
                        controller: _fullNameController,
                        validator: (value) =>
                            validateInput(value, min: 2, max: 50),
                      ),
                      VerticalSpacer(18),
                      Label(label: 'Email Address'),
                      Input(
                        hintText: 'Email',
                        controller: _emailController,
                        readOnly: true,
                      ),
                      VerticalSpacer(18),
                      Label(label: 'Phone Number'),
                      Input(
                        hintText: 'E.g: 01234567',
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: CustomPrefixIcon(icon: LucideIcons.phone),
                        validator: (value) => validateInput(
                          value,
                          type: InputType.number,
                          min: 8,
                          max: 8,
                        ),
                      ),
                      VerticalSpacer(18),
                      Label(label: 'Gender'),
                      ValueListenableBuilder<String?>(
                        valueListenable: _selectedGender,
                        builder: (context, value, child) =>
                            CustomDropdown<String>(
                              hintText: 'Select your gender',
                              prefixIcon: const CustomPrefixIcon(
                                icon: LucideIcons.shield,
                              ),
                              items: ['Male', 'Female'].map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: AppStyle.styleSemiBold14,
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                _selectedGender.value = newValue;
                              },
                              initialValue: _selectedGender.value,
                              validator: (newValue) => validateSelect(newValue),
                            ),
                      ),
                      VerticalSpacer(22),
                      PrimaryButton(
                        text: 'Save Changes',
                        isLoading: _isSaving,
                        onPressed: _saveProfile,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
