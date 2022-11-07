import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:e_markety_client/features/user/blocs/user_bloc.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/assets.dart';
import '../../admin/product/components/text_field_with_label.dart';
import '../models/user.dart';

class AvatarContainer extends StatefulWidget {
  const AvatarContainer({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<AvatarContainer> createState() => _AvatarContainerState();
}

class _AvatarContainerState extends State<AvatarContainer> {
  late User _user = widget.user;

  void _onUrlChanged(String url) => _user = _user.copyWith(avatarUrl: url);

  void _onChangeImagePressed() {
    Asuka.showDialog(
      builder: (context) => AlertDialog(
        content: _AvatarSelector(
          url: _user.avatarUrl,
          onUrlChanged: _onUrlChanged,
        ),
        title: const Text('Alterar imagem'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Modular.get<UserBloc>().add(UserUpdateEvent(_user));
              Navigator.of(context).pop();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CircleAvatar(
          radius: _deviceWidth * 0.16, // 95 // 0.225
          backgroundColor: Colors.white.withOpacity(0.4),
          child: CircleAvatar(
            radius: _deviceWidth * 0.135, // 83 // 0.2
            backgroundImage: NetworkImage(_user.avatarUrl),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            elevation: 6,
            shadowColor: kPrimaryColor,
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              radius: 20,
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: _onChangeImagePressed,
                  splashColor: kPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AvatarSelector extends StatefulWidget {
  const _AvatarSelector({
    Key? key,
    required this.url,
    required this.onUrlChanged,
  }) : super(key: key);

  final String url;
  final void Function(String) onUrlChanged;

  @override
  State<_AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<_AvatarSelector> {
  late String _url = widget.url;

  Widget _buildImage() {
    if (_url.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: Image.asset(Assets.avatarPlaceholder, fit: BoxFit.fill),
      );
    }
    return Image.network(_url, fit: BoxFit.fill);
  }

  Future<void> _onChanged(String url) async {
    try {
      await Modular.get<Dio>().get(url);
      setState(() => _url = url);
    } catch (e) {
      setState(() => _url = '');
    }
    widget.onUrlChanged(_url);
  }

  // https://i.pinimg.com/236x/7d/0e/68/7d0e68d3982cf67cfe6504e165029bd1--wattpad-book.jpg
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithLabel(
          label: 'Imagem URL',
          onChanged: _onChanged,
          data: _url,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: const Color(0XFFEEEEEE)),
            ),
            child: _buildImage(),
          ),
        ),
      ],
    );
  }
}
