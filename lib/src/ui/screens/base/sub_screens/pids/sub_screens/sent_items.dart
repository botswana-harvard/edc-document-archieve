import 'package:flutter/material.dart';

class SentItemScreen extends StatelessWidget {
  const SentItemScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.check),
                text: 'Sent Items',
              ),
              Tab(
                icon: Icon(Icons.cloud_sync_outlined),
                text: 'Pending Sync',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text('150-222-333-032 - Clinician Notes'),
                    subtitle: Text('Sent on 26/08/202 12:45'),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 20,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.cloud_off_outlined, color: Colors.red),
                    title: const Text('150-222-333-032 - Clinician Notes'),
                    subtitle: const Text('Added on 26/08/202 12:45'),
                    trailing: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 20,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          child: const ElevatedButton(
            child:
                Text('Synchronise data', style: TextStyle(color: Colors.blue)),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
