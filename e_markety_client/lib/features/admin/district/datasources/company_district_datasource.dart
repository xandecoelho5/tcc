import 'package:e_markety_client/features/admin/shared/data_responses/company_district_page_response.dart';
import 'package:e_markety_client/features/admin/shared/widgets/action_button.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/dialog_utils.dart';
import '../../../company/blocs/company_district/company_district_bloc.dart';
import '../../../company/models/company_district.dart';

class CompanyDistrictDataSource extends DataTableSource {
  final CompanyDistrictPageResponse _pageResponse;

  CompanyDistrictDataSource(this._pageResponse);

  void _onDeleteProduct(int id) {
    DialogUtils.showDialog(
      'Excluir bairro',
      'Deseja realmente excluir o bairro?',
      () => Modular.get<CompanyDistrictBloc>().add(
        CompanyDistrictDeleteByIdEvent(id),
      ),
    );
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0, 'index deve ser maior que 0');

    if (index >= _pageResponse.totalElements) return null;

    CompanyDistrict companyDistrict;
    try {
      companyDistrict = _pageResponse.content[index % _pageResponse.size];
    } catch (e) {
      return null;
    }

    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.all(Colors.white),
      cells: [
        DataCell(Text(companyDistrict.district!.name)),
        DataCell(Text(companyDistrict.deliveryCharge.toReal)),
        DataCell(
          Row(
            children: [
              ActionButton(
                iconData: Icons.edit,
                color: kSecondaryColor,
                onPressed: () => Modular.to.navigate(
                  '/admin/company-district/edit/${companyDistrict.id}',
                ),
              ),
              ActionButton(
                iconData: Icons.delete,
                color: kPrimaryColor,
                onPressed: () => _onDeleteProduct(companyDistrict.id!),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _pageResponse.totalElements;

  @override
  int get selectedRowCount => 0;
}
