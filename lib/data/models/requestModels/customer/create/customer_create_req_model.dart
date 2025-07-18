import 'dart:io';

class CustomerCreateRequestModel {
  final List<String> websites;
  final List<String> divisions;
  final String source;
  final String addressType;
  final String gstin;
  final String organization;
  final String dob;
  final String assignedTo;
  final String customerType;
  final String country;
  final String state;
  final String district;
  final String pincode;
  final String city;
  final String otherInformation;
  final String aboutClient;
  final String primaryAddress;
  final String primaryContact;
  final String primaryEmail;
  final String lastName;
  final String firstName;
  final String type;
  final String countryCode;
  final double lat;
  final double lng;
  final String? order;
  final String? orderPerformaInvoice;
  final File? initialPaymentAttachment;
  final dynamic serviceArea;

  CustomerCreateRequestModel({
    required this.websites,
    required this.divisions,
    required this.source,
    required this.addressType,
    required this.gstin,
    required this.organization,
    required this.dob,
    required this.assignedTo,
    required this.customerType,
    required this.country,
    required this.state,
    required this.district,
    required this.pincode,
    required this.city,
    required this.otherInformation,
    required this.aboutClient,
    required this.primaryAddress,
    required this.primaryContact,
    required this.primaryEmail,
    required this.lastName,
    required this.firstName,
    required this.type,
    required this.countryCode,
    required this.lat,
    required this.lng,
    this.order,
    this.orderPerformaInvoice,
    this.initialPaymentAttachment,
    this.serviceArea,
  });

  Future<Map<String, dynamic>> toFormData() async {
    return {
      'divisions[0]': divisions.isNotEmpty ? divisions[0] : null,
      'address_type': addressType.isEmpty ? null : addressType,
      'gstin': gstin.isEmpty ? null : gstin,
      'organization': organization.isEmpty ? null : organization,
      'dob': dob.isEmpty ? null : dob,
      'country': country.isEmpty ? null : country,
      'state': state.isEmpty ? null : state,
      'district': district.isEmpty ? null : district,
      'pincode': pincode.isEmpty ? null : pincode,
      'city': city.isEmpty ? null : city,
      'other_information': otherInformation.isEmpty ? null : otherInformation,
      'about_client': aboutClient.isEmpty ? null : aboutClient,
      'primary_address': primaryAddress.isEmpty ? null : primaryAddress,
      'primary_contact': primaryContact.isEmpty ? null : primaryContact,
      'primary_email': primaryEmail.isEmpty ? null : primaryEmail,
      'last_name': lastName.isEmpty ? null : lastName,
      'first_name': firstName.isEmpty ? null : firstName,
      'source': source.isEmpty ? null : source,
      'type': type.isEmpty ? null : type,
      'assigned_to': assignedTo.isEmpty ? null : assignedTo,
      'country_code': countryCode.isEmpty ? null : countryCode,
      'order': order,
      'order_performa_invoice': orderPerformaInvoice,
      'initial_payment_attachment': initialPaymentAttachment?.path ?? null,
      'serviceArea': serviceArea,
      'lat': lat.toString(),
      'lng': lng.toString(),
    }..removeWhere((key, value) => value == null);
  }
}