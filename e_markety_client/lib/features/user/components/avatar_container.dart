import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 95,
          backgroundColor: Colors.white.withOpacity(0.4),
          child: CircleAvatar(
            radius: 83,
            backgroundImage: NetworkImage(url),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            elevation: 6,
            shadowColor: kPrimaryColor,
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              radius: 24,
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {},
                  splashColor: kPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
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
