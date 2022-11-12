import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/client/payments/create/client_payments_create_controller.dart';

// ignore: must_be_immutable
class ClientPaymentsCreatePage extends StatelessWidget {

  ClientPaymentsCreateController con = Get.put(ClientPaymentsCreateController());

  ClientPaymentsCreatePage({super.key});

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
                cardBgColor: const Color(0xffA47E3B),
                obscureCardNumber: true,
                obscureCardCvv: false,
                height: 175,
                isHolderNameVisible: true,
                isChipVisible: true,
                labelCardHolder: 'NOMBRE Y APELLIDO',
                textStyle: const TextStyle(color: Colors.black),
                width: MediaQuery.of(context).size.width,
                animationDuration: const Duration(milliseconds: 1000), 
                // ignore: non_constant_identifier_names
                onCreditCardWidgetChange: (CreditCardBrand ) {  },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CreditCardForm(
                  formKey: con.keyForm, // Required
                  onCreditCardModelChange: con.onCreditCardModelChanged, // Required
                  themeColor: Colors.red,
                  obscureCvv: false,
                  obscureNumber: true,
                  cardNumberValidator: (String? cardNumber){
                    return null;
                  },
                  expiryDateValidator: (String? expiryDate){
                    return null;
                  },
                  cvvValidator: (String? cvv){
                    return null;
                  },
                  cardHolderValidator: (String? cardHolderName){
                    return null;
                  },
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
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15)
        ),
        child: const Text(
          'CONTINUAR',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }

}
