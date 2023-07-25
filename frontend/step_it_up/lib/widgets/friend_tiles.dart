import 'package:flutter/material.dart';
import 'package:step_it_up/models/friend_model.dart';

class ActiveFriendTile extends StatelessWidget {
  final Friend friend;

  ActiveFriendTile({required this.friend});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 10),
          Expanded(child: Text(friend.name)),
        ],
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Invite'),
          onTap: () {
            debugPrint('Invite pressed for ${friend.name}');
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () {
            debugPrint('Delete pressed for ${friend.name}');
          },
        ),
      ],
    );
  }
}

class PendingFriendTile extends StatelessWidget {
  final Friend friend;

  PendingFriendTile({required this.friend});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 10),
          Expanded(child: Text(friend.name)),
        ],
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.check),
          title: const Text('Accept'),
          onTap: () {
            debugPrint('Accept pressed for ${friend.name}');
          },
        ),
        ListTile(
          leading: const Icon(Icons.close),
          title: const Text('Decline'),
          onTap: () {
            debugPrint('Decline pressed for ${friend.name}');
          },
        ),
      ],
    );
  }
}