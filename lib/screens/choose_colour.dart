import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import '../widgets/elevatedbutton_widget.dart';
import '../widgets/popup_menu_widget.dart';
import '../widgets/textformfield_widget.dart';

class ChooseColour extends StatefulWidget {
  static const routeName = '/choose-colour';
  const ChooseColour({Key? key}) : super(key: key);

  @override
  State<ChooseColour> createState() => _ChooseColourState();
}

class _ChooseColourState extends State<ChooseColour> {
  final _form = GlobalKey<FormState>();
  Color userChosenColour = const Color.fromRGBO(255, 255, 255, 1);
  Color decorationColour = Colors.black;

  TextEditingController rController = TextEditingController();
  TextEditingController gController = TextEditingController();
  TextEditingController bController = TextEditingController();

  @override
  void dispose() {
    rController.dispose();
    gController.dispose();
    bController.dispose();
    super.dispose();
  }

  String? formValidator(String? text) {
    if(text == null || int.tryParse(text) == null) {
      return 'The field cannot be empty';
    }
    if (int.tryParse(text)! > 256) {
      return 'The value should be less than 256';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colourProvider = Provider.of<ColourProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.home,
              color: colourProvider.decorationColour,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuWidget(
            color: colourProvider.decorationColour,
          ),
        ],
      ),
      body: Container(
        color: colourProvider.userChosenColour,
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Complete with RGB',
                style: TextStyle(color: colourProvider.decorationColour),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormFieldWidget(
                            validator: formValidator,
                            decorationColour: colourProvider.decorationColour,
                            labelText: 'R',
                            fieldController: rController,
                            onChanged: (text) {
                              setState(() {
                                _form.currentState!.validate();
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormFieldWidget(
                            validator: formValidator,
                            decorationColour: colourProvider.decorationColour,
                            labelText: 'G',
                            fieldController: gController,
                            onChanged: (text) {
                              setState(() {
                                _form.currentState!.validate();
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormFieldWidget(
                          validator: formValidator,
                          decorationColour: colourProvider.decorationColour,
                          labelText: 'B',
                          fieldController: bController,
                          onChanged: (text) {
                            setState(() {
                              _form.currentState!.validate();
                            });
                          },
                        ),
                      )
                    ],
                  )),
              ElevatedButtonWidget(
                onPressed: rController.text.isNotEmpty &&
                        gController.text.isNotEmpty &&
                        bController.text.isNotEmpty
                    ? () => colourProvider.showChosenColour(
                        rController.text, gController.text, bController.text)
                    : null,
                text: 'Show colour',
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButtonWidget(
                onPressed: rController.text.isNotEmpty &&
                        gController.text.isNotEmpty &&
                        bController.text.isNotEmpty
                    ? () => colourProvider.showComplementaryColour(
                        rController.text, gController.text, bController.text)
                    : null,
                text: 'Opposite colour',
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
