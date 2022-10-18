import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/order/address/exceptions/address_exception.dart';

import '../models/address.dart';

abstract class IAddressService {
  Future<Either<AddressException, List<Address>>> getAddresses();

  Future<Either<AddressException, Address>> getDefaultAddress();
// Future<Address> addAddress(Address address);
// Future<Address> updateAddress(Address address);
// Future<void> deleteAddress(Address address);
}

class AddressService implements IAddressService {
  final IHttpService _httpService;
  final String _baseUrl = '/endereco';

  AddressService(this._httpService);

  @override
  Future<Either<AddressException, List<Address>>> getAddresses() async {
    final response = await _httpService.getAll(_baseUrl);
    return response.fold(
      (l) => Left(AddressException(l.message, l.stackTrace)),
      (r) => Right(r.map(Address.fromMap).toList()),
    );
  }

  @override
  Future<Either<AddressException, Address>> getDefaultAddress() async {
    final response = await _httpService.get('$_baseUrl/padrao');
    return response.fold(
      (l) => Left(AddressException(l.message, l.stackTrace)),
      (r) => Right(Address.fromMap(r)),
    );
  }
}
