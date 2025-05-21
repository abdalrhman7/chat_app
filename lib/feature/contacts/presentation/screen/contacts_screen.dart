import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/feature/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<ContactsCubit, ContactsState>(
        listener: (context, state) async {
          var cubit = context.read<ContactsCubit>();
          if (state is ConversationReady) {
            var res = await Navigator.pushNamed(context, Routes.chatScreen,
                arguments: {
                  'conversationId': state.conversationId,
                  'participantName': state.contactName,
                });
            if (res == null) {
              cubit.fetchContacts();
            }
          }

        },
        builder: (context, state) {
          if (state is ContactsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactsLoaded) {
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ListTile(
                  title: Text(
                    contact.username,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    contact.email,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Navigator.pop(context, contact);
                    context.read<ContactsCubit>().checkOrCreateConversation(
                        contactId: contact.id, contactName: contact.username);
                  },
                );
              },
            );
          } else if (state is ContactsError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text('No contacts found'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddContactDialog(context),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Add Contact',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter Contact Email',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(color: Colors.white)),
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  context.read<ContactsCubit>().addContact(email);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
