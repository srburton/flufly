


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberComponent extends StatefulWidget{

  final TextEditingController? controller;

  PhoneNumberComponent({
    this.controller
  });

  @override
  State<PhoneNumberComponent> createState() => _PhoneNumberComponent();

}

class _PhoneNumberComponent extends State<PhoneNumberComponent>{

  String initialCountry = 'BR';
  PhoneNumber number = PhoneNumber(isoCode: 'BR');

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: InternationalPhoneNumberInput(
          initialValue: number,
          textFieldController: widget.controller,
          formatInput: false,
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorConfig: SelectorConfig(
            showFlags: true,
            trailingSpace: false,
            setSelectorButtonAsPrefixIcon: true,
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
          selectorTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          keyboardType: TextInputType.numberWithOptions(
              signed: true,
              decimal: true
          ),
          inputDecoration: InputDecoration(
              hintText: 'Enter your phone number',
              border: InputBorder.none,
              labelStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal
              ),
              hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey
              )
          ),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          }
        )
    );
  }

}
