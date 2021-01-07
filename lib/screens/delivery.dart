import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class DeliveryScreen extends BasePage{
   DeliveryScreen({Key key}) : super(key: key);
  @override
  DeliveryScreenState createState() => DeliveryScreenState();
}
class DeliveryScreenState extends BasePageState<DeliveryScreen>{
  int _currentStep = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Delivery Information", suffixIcon: Container()),
      body: stepperBuilder(),
    );
  }

  Widget stepperBuilder(){
    return Container(
      child: Theme(data: ThemeData(primaryColor: orange), child:  new Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        physics: ClampingScrollPhysics(),
        controlsBuilder: _createEventControlBuilder,
        onStepTapped: (int step) => setState(() => _currentStep = step),
        onStepContinue: _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
        onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
        steps: <Step>[
          new Step(
            title: new Text('Shipping',style: styleProvider(fontWeight: medium, size: 12, color: black),),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
            content:  Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHelper.fieldLabel("First Name", regular, 10, color: grey),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  }),
                  FormHelper.fieldLabel("First Name", extraLight, 12),
                  FormHelper.textInput(context, "", (){

                  })
                ],
              ),
            ),
          ),
          new Step(
            title: new Text('Payment'),
            content: new Text('This is the second step.',style: styleProvider(fontWeight: medium, size: 12, color: black),),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          new Step(
            title: new Text('Order',style: styleProvider(fontWeight: medium, size: 12, color: black),),
            content: new Text('This is the third step.'),
            isActive: _currentStep >= 0,
            state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
        ],)),
    );
  }
  Widget _createEventControlBuilder(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: onStepCancel,
            child: Text('Previous', style: styleProvider(fontWeight: medium, size: 12),),
          ),
          FlatButton(
            onPressed: onStepContinue,
            child: Text('Next', style: styleProvider(fontWeight: medium, size: 12),),
          ),
        ]
    );
  }
}