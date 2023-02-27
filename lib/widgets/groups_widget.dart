import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_byte/dataprovider/data_provider.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/repository/groups_repo.dart';
import 'package:task_byte/widgets/groups_container.dart';

class GroupsWidget extends ConsumerWidget {
  const GroupsWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(groupDataProvider);
    return Scaffold(
      body: data.when(
        data: (data) {
          List<Groups> userGroup = data.map((e) => e).toList();
          print(userGroup);
          print("Did you see?");
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Groups",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Groups>>(
                  future: GroupsRepositoryImpl().getAllRemoteGroups(),
                  builder: (context, snapshot) {
                    print("Is data Coming");
                    print(snapshot);
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GroupContainer(
                              group: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                            // child: CircularProgressIndicator(
                            //   color: Colors.green,
                            // ),
                            child: Text("No Groups"));
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(
          err.toString(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class GroupsWidget extends StatefulWidget {
//   const GroupsWidget({super.key});

//   @override
//   State<GroupsWidget> createState() => _GroupsWidgetState();
// }

// class _GroupsWidgetState extends State<GroupsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
