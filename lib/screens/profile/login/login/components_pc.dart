import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey,
        ),
        Positioned.fill(
          child: Image.asset(
            'assets/images/registerbackground.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: 15,
        child: Text(
          'HOUSLY.AI',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ));
  }
}

class ExtendedSocialButtonsRow extends StatelessWidget {
  final BuildContext context;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;
  final VoidCallback? onFacebookTap;

  const ExtendedSocialButtonsRow({
    super.key,
    required this.context,
    this.onGoogleTap,
    this.onAppleTap,
    this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        SocialButton(imagePath: 'assets/images/google.png', onTap: onGoogleTap),
        SocialButton(imagePath: 'assets/images/apple.png', onTap: onAppleTap),
        SocialButton(
            imagePath: 'assets/images/facebook.png', onTap: onFacebookTap),
        const Spacer(),
      ],
    );
  }
}

class BrandHeader extends StatelessWidget {
  final bool isSmallScreen;

  const BrandHeader({super.key, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'HOUSLY.AI',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class FormContainer extends StatelessWidget {
  final double containerWidth;
  final bool isSmallScreen;
  final Widget formContent;

  const FormContainer({
    super.key,
    required this.containerWidth,
    required this.isSmallScreen,
    required this.formContent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: containerWidth,
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 16 : 20,
          horizontal: isSmallScreen ? 12 : 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: formContent,
      ),
    );
  }
}

class FormHeader extends StatelessWidget {
  final bool isSmallScreen;
  final String title;

  const FormHeader(
      {super.key, required this.isSmallScreen, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: isSmallScreen ? 24 : 28,
        ),
      ),
    );
  }
}

class SocialButtonsRow extends StatelessWidget {
  final BuildContext context;

  const SocialButtonsRow({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Spacer(),
        SocialButton(imagePath: 'assets/images/google.png'),
        SocialButton(imagePath: 'assets/images/apple.png'),
        SocialButton(imagePath: 'assets/images/facebook.png'),
        Spacer(),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const SocialButton({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: ElevatedButton(
          onPressed:
              () {}, // Kept for compatibility, but onTap will handle the action
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
          ),
          child: SizedBox(
            height: 30,
            width: 35,
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 30,
                width: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xffE2E8F0))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('or'),
        ),
        Expanded(child: Divider(color: Color(0xffE2E8F0))),
      ],
    );
  }
}

class ValidatedTextField extends StatelessWidget {
  final Iterable<String>? autofillHints;
  final TextEditingController controller;
  final String label;
  final double padding;
  final String? Function(String?)? validator;
  final bool obscureText;

  const ValidatedTextField({
    super.key,
    this.padding = 20,
    this.autofillHints,
    required this.controller,
    required this.label,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      autofillHints: autofillHints,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xff919191),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        fillColor: Colors.white,
        filled: true,
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 3),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      validator: validator,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff232323),
              minimumSize: const Size.fromHeight(42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
