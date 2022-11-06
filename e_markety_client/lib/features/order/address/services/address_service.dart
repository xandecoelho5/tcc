import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/order/address/exceptions/address_exception.dart';

import '../models/address.dart';

abstract class IAddressService {
  Future<Either<AddressException, List<Address>>> getAddresses();

  Future<Either<AddressException, Address>> getDefaultAddress();

  Future<Either<AddressException, Address>> getAddressById(int id);

  Future<Either<AddressException, void>> addAddress(Address address);

  Future<Either<AddressException, Address>> updateAddress(Address address);

  Future<Either<AddressException, void>> deleteAddressById(int id);
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

  @override
  Future<Either<AddressException, Address>> getAddressById(int id) async {
    final response = await _httpService.get('$_baseUrl/$id');
    return response.fold(
      (l) => Left(AddressException(l.message, l.stackTrace)),
      (r) => Right(Address.fromMap(r)),
    );
  }

  @override
  Future<Either<AddressException, Address>> updateAddress(
    Address address,
  ) async {
    final response = await _httpService.put(
      '$_baseUrl/${address.id}',
      address.toMap(),
    );
    return response.fold(
      (l) => Left(AddressException(l.message, l.stackTrace)),
      (r) => Right(Address.fromMap(r)),
    );
  }

  @override
  Future<Either<AddressException, void>> addAddress(Address address) async {
    final response = await _httpService.post(_baseUrl, address.toMap());
    return response.fold(
      (l) => Left(AddressException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<AddressException, void>> deleteAddressById(int id) async {
    final response = await _httpService.delete('$_baseUrl/$id');
    return response.fold(
      (l) => Left(AddressException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }
}
