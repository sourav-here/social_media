import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/controller/provider.dart';
import 'package:social_media/models/usersmodel.dart';
import 'package:social_media/services/user_services.dart';
import 'package:social_media/view/details_screen.dart';
import 'package:social_media/view/profilepage.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        title: const Text('Registered Users'),
      ),
      body: FutureBuilder(
          future: fetchAllUserData(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            } else {
              return Consumer<UserProvider>(
                  builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    final UsersModel data = provider.users[index];
                    final bool isFollowing = provider.isFollowingUser(data.id!);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                userName: data.username!,
                                userEmail: data.email!)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: SizedBox(
                          height: 80,
                          child: Card(
                            color: const Color.fromARGB(31, 72, 72, 72),
                            child: Align(
                              alignment: Alignment.center,
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // provider.deleteContact(
                                          //     data.id.toString());
                                          UserService.deleteUser(data.id!);
                                          provider.deleteContact(
                                              data.id.toString());
                                        },
                                        icon: const Icon(Icons.delete)),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            padding: const MaterialStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: 10)),
                                            foregroundColor:
                                                MaterialStatePropertyAll(
                                                    isFollowing
                                                        ? Colors.black
                                                        : Colors.white),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    isFollowing
                                                        ? Colors.white
                                                        : Colors.blue)),
                                        onPressed: () {
                                          if (isFollowing) {
                                            UserService().unFollowUser(
                                                context, data.id!);
                                            provider.removeFollowing(data.id!);
                                          } else {
                                            UserService()
                                                .followUser(context, data.id!);
                                            provider.addFollowing(data.id!);
                                          }
                                        },
                                        child: Text(
                                            isFollowing ? 'Unfollow' : 'Follow')),
                                  ],
                                ),
                                title: Text(
                                  data.username!.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        },
        child: const Icon(Icons.person),
      ),
    );
  }

  Future<void> fetchAllUserData(BuildContext context) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    await provider.fetchUsers(context);
  }
}
