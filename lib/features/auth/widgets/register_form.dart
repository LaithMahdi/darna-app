import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/custom_dropdown.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/forms/role_selector.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import 'auth_obscure_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isConfirmPasswordObscure = ValueNotifier<bool>(
    true,
  );
  final ValueNotifier<String?> _selectedGender = ValueNotifier<String?>(null);
  final ValueNotifier<String> _selectedRole = ValueNotifier<String>("Owner");

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formRegisterKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: _selectedRole,
            builder: (context, value, child) => RoleSelector(
              selectedRole: _selectedRole.value,
              onRoleSelected: (role) {
                _selectedRole.value = role;
              },
            ),
          ),
          VerticalSpacer(20),
          Label(label: "Full Name"),
          Input(
            hintText: "E.g: John Doe",
            controller: _fullNameController,
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.user),
            keyboardType: TextInputType.name,
            validator: (value) => validateInput(value, min: 2, max: 100),
          ),
          VerticalSpacer(20),
          Label(label: "Email Address"),
          Input(
            hintText: "E.g: example@gmail.com",
            controller: _emailController,
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.mail),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                validateInput(value, type: InputType.email, min: 8, max: 150),
          ),
          VerticalSpacer(20),
          Label(label: "Phone Number"),
          Input(
            hintText: "E.g: 0123456789",
            controller: _phoneNumberController,
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.phone),
            keyboardType: TextInputType.phone,
            validator: (value) =>
                validateInput(value, type: InputType.number, min: 8, max: 8),
          ),
          VerticalSpacer(20),
          Label(label: "Gender"),
          ValueListenableBuilder<String?>(
            valueListenable: _selectedGender,
            builder: (context, value, child) => CustomDropdown<String>(
              hintText: "Select your gender",
              prefixIcon: const CustomPrefixIcon(icon: LucideIcons.shield),
              items: ["Male", "Female"].map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender, style: AppStyle.styleSemiBold14),
                );
              }).toList(),
              onChanged: (value) {
                _selectedGender.value = value;
              },
              initialValue: _selectedGender.value,
              validator: (value) => validateSelect(value),
            ),
          ),
          VerticalSpacer(20),
          Label(label: "Password"),
          ValueListenableBuilder<bool>(
            valueListenable: _isPasswordObscure,
            builder: (context, value, child) => Input(
              hintText: "E.g: ********",
              controller: _passwordController,
              prefixIcon: CustomPrefixIcon(icon: LucideIcons.lock),
              obscureText: value,
              suffixIcon: AuthObscureButton(
                isObscure: value,
                onPressed: () {
                  _isPasswordObscure.value = !_isPasswordObscure.value;
                },
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => validateInput(
                value,
                type: InputType.password,
                min: 8,
                max: 25,
              ),
            ),
          ),
          VerticalSpacer(20),
          Label(label: "Confirm Password"),
          ValueListenableBuilder<bool>(
            valueListenable: _isConfirmPasswordObscure,
            builder: (context, value, child) => Input(
              hintText: "E.g: ********",
              controller: _confirmPasswordController,
              prefixIcon: CustomPrefixIcon(icon: LucideIcons.lock),
              obscureText: value,
              suffixIcon: AuthObscureButton(
                isObscure: value,
                onPressed: () {
                  _isConfirmPasswordObscure.value =
                      !_isConfirmPasswordObscure.value;
                },
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => validateInput(
                value,
                type: InputType.password,
                min: 8,
                max: 25,
              ),
            ),
          ),
          VerticalSpacer(20),
          PrimaryButton(
            text: "Sign Up",
            onPressed: () {
              if (_formRegisterKey.currentState!.validate()) {
                // Perform registration logic here
              }
            },
          ),
        ],
      ),
    );
  }
}
