import 'package:flutter/material.dart';
import 'package:flutter_sdmga19/models/payment.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms'),
      ),
      body: PaymentForm(), //we will add this in a bit
    );
  }
}

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key key}):super(key: key);
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _cardNumberController = TextEditingController();
  final _nameController= new TextEditingController();
  final _securityController = new TextEditingController();
  final _paymentPostalCode = new TextEditingController();
  final _paymentAddressLine = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //CardDetails _cardDetails = new CardDetails("", '', '', '', 0123);
  String expiryMonth;
  String expiryYear;
  final List yearList = List.generate(12, (int index) => index+2021);

  Map<String, bool> touched = {
    "cardNumberField": false,
  };


  bool rememberInfo = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [

            Column(
              children: [

                TextFormField(
                  controller: _nameController,
                  //onSaved: (val)=>_cardDetails.cardHolderName=val,
                  decoration: InputDecoration(
                    labelText: 'Name on Card',
                    icon: Icon(Icons.account_circle),
                  ),
                  validator: (value){
                    if(value.isEmpty) return "This value must be filled";
                        return null;
                  },
                ),

                TextFormField(
                  //onSaved: (val)=>_cardDetails.cardNumber=val,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    icon: Icon(Icons.credit_card),
                  ),
                  validator: (value){
                    if(value.isEmpty) return "This field should not be empty";
                    if(value.length!=16) return "Please Enter a valid Number";
                    return null;
                  },
                  //autovalidate: true,
                  //autovalidateMode: AutovalidateMode.always,
                  autovalidate: touched['cardNumberField'],

                  onChanged: (value){
                    setState(() {
                      touched['cardNumberField']=true;
                    });
                  },

                  controller: _cardNumberController,
                ),

                TextFormField(
                  controller: _securityController,
                  //onSaved: (val)=>_cardDetails.securityCode=int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Security Code',
                    icon: Icon(Icons.security_outlined),
                  ),
                  maxLength: 4,
                ),
                
                DropdownButtonFormField<String>(
                    //onSaved: (val)=> _cardDetails.expiryMonth=val,
                    value: expiryMonth,
                    items: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'].map<DropdownMenuItem<String>>(
                        (String val){
                          return DropdownMenuItem(
                              child: Text(val),
                              value: val,
                          );
                        },
                    ).toList(), //items

                  onChanged: (val){
                      setState(() {
                        expiryMonth=val;
                      });
                  }, //onChanged

                  decoration: InputDecoration(
                    labelText: 'Expiry Month',
                    icon: Icon(Icons.calendar_today),
                  ),
                ),

                DropdownButtonFormField(
                  //onSaved: (val)=> _cardDetails.expiryYear=val,
                  value: expiryYear,
                  items: yearList.map<DropdownMenuItem>(
                      (val){
                        return DropdownMenuItem(
                            child: Text(val.toString()),
                            value: val.toString(),

                        );
                      }
                  ).toList(), //items

                  onChanged: (val){
                    setState(() {
                      expiryYear=val.toString();
                    });
                  }, //onChanged

                  decoration: InputDecoration(
                    labelText: 'Expiry Year',
                    icon: Icon(Icons.calendar_today),
                  ),

                ),

                TextFormField(
                  controller: _paymentPostalCode,
                  //onSaved: (val) => _paymentAddress.postCode = val,
                  decoration: InputDecoration(
                      labelText: 'Post Code', icon: Icon(Icons.location_on)),
                ),

                TextFormField(
                  controller: _paymentAddressLine,
                 // onSaved: (val) => _paymentAddress.addressLine = val,
                  decoration: InputDecoration(
                      labelText: 'Address Line', icon: Icon(Icons.location_city)),
                ),
                
                CheckboxListTile(
                    value: rememberInfo,
                    onChanged: (val){
                      setState(() {
                        rememberInfo = val;
                      });
                    },
                  title: Text('Remember Information'),

                ),

                RaisedButton(
                  child: Text('Process Payment'),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  onPressed: ()  {
                    CardDetails _cardDetails = new CardDetails(_nameController.text.toString(), _cardNumberController.text.toString(), expiryMonth, expiryYear,int.parse(_securityController.text));
                    Address _paymentAddress = new Address(_paymentPostalCode.text.toString(),_paymentAddressLine.text.toString());
                    Payment payment = new Payment(
                      _paymentAddress,_cardDetails
                    );
                    print("Name:"+payment.cardDetails.cardHolderName);
                    print("Address:"+payment.address.postCode);
                  },
                ),

              ],

            ) //we will work here

          ],
        ),
      ),
    );
  }
}





