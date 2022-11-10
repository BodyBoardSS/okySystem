import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/client/payments/create/client_payments_create_controller.dart';

// ignore: must_be_immutable
class ClientPaymentsCreatePage extends StatelessWidget {

  ClientPaymentsCreateController con = Get.put(ClientPaymentsCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: _buttonNext(context),
        body: ListView(
            children: [
              CreditCardWidget(
                cardNumber: con.cardNumber.value,
                expiryDate: con.expireDate.value,
                cardHolderName: con.cardHolderName.value,
                cvvCode: con.cvvCode.value,
                showBackView: con.isCvvFocused.value,
                cardBgColor: Colors.black54,
                obscureCardNumber: true,
                obscureCardCvv: true,
                height: 175,
                labelCardHolder: 'NOMBRE Y APELLIDO',
                textStyle: TextStyle(color: Colors.white),
                width: MediaQuery.of(context).size.width,
                animationDuration: Duration(milliseconds: 1000), 
                onCreditCardWidgetChange: (CreditCardBrand ) {  },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CreditCardForm(
                  formKey: con.keyForm, // Required
                  onCreditCardModelChange: con.onCreditCardModelChanged, // Required
                  themeColor: Colors.red,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumberValidator: (String? cardNumber){},
                  expiryDateValidator: (String? expiryDate){},
                  cvvValidator: (String? cvv){},
                  cardHolderValidator: (String? cardHolderName){},
                  onFormComplete: () {
                    // callback to execute at the end of filling card data
                  },
                  cardNumberDecoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card) ,
                    labelText: 'Numero de la tarjeta',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    labelText: 'Expiracion',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    suffixIcon: Icon(Icons.lock),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    labelText: 'Titular de la tarjeta',
                  ),
                  cvvCode: '',
                  expiryDate:'',
                  cardHolderName: '',
                  cardNumber: '',
                ),
              ),
        ],
      ),
    ));
  }

  Widget _buttonNext(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)
        ),
        child: Text(
          'CONTINUAR',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }

}
