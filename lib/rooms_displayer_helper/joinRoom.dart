import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:flutter/cupertino.dart';

class JoinRoom extends StatelessWidget {
  static const String routeName = 'joinRoom';
  @override
  Widget build(BuildContext context) {
    final Room roomArgs = ModalRoute.of(context)!.settings.arguments as Room;
    return Container();
  }
}
