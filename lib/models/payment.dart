
class Address{
  String postCode;
  String addressLine;

  Address(this.postCode, this.addressLine);

}

class CardDetails{
  String cardHolderName;
  String cardNumber;
  String expiryMonth;
  String expiryYear;
  int securityCode;

  CardDetails(this.cardHolderName, this.cardNumber, this.expiryMonth,
      this.expiryYear, this.securityCode);
}

class Payment{
  Address address;
  CardDetails cardDetails;

  Payment(this.address, this.cardDetails);
}