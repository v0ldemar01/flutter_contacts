import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/utils/fetch/getContacts.dart';

import 'contact_page.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController editingController = TextEditingController();
  var contacts = List();
  var displayContacts = List();
  bool _shouldShow = true;

  @override
  void initState() {
    super.initState();
    // getContacts().then((response) {
    //   setState(() {
    //     contacts = response;
    //     print(contacts);
    //   });
    // });
  }  

  void filterSearchResults(String query) {       
    if(query.isNotEmpty) {
      var dummyListData = List();
      contacts.forEach((item) {        
        if(item.name.contains(query)) {          
          dummyListData.add(item);
        }
      });
      setState(() {
        displayContacts.clear();
        displayContacts.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        displayContacts.clear();
        displayContacts.addAll(contacts);
      });
    }
  }

  void _navigateAndDisplaySelection(int index) async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactElement(contact: displayContacts[index])),
    );    
    setState(() {
      if (result.runtimeType == String) {
        contacts.removeWhere((element) => element.name == result);   
      } else if (result.runtimeType == Contact) {        
        contacts.forEach((element) {
          if (element.email == result.email) {
            element.name = result.name;
            element.phone = result.phone;
          }          
        });
      }         
      displayContacts.clear();
      displayContacts.addAll(contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: <Widget>[
            _buildSearch(),
            _buildContactList(),
          ],
        ),
      ),
      floatingActionButton: _buildButton(),
    );
  }  

  Widget _buildSearch() => Padding(
    padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
    child: TextField(
      onChanged: (value) => filterSearchResults(value),
      controller: editingController,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: editingController.clear,
          icon: Icon(Icons.clear),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    ),
  );

  Widget _buildContactList() => Expanded(
    child: ListView.builder(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 50.0, bottom: 50.0),
      shrinkWrap: true,
      itemCount: displayContacts.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Card(
          elevation: 0,
          child: Column(                    
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                tileColor: Colors.grey[200],
                leading: Icon(Icons.perm_contact_cal_rounded, size: 40),
                trailing: IconButton(
                  onPressed: () {
                    print('$index');
                    _navigateAndDisplaySelection(index);
                  },
                  icon: Icon(Icons.info_outline),
                ),
                title: Text(displayContacts[index].name),
                subtitle: Text(displayContacts[index].email),
                contentPadding: EdgeInsets.only(left: 40.0, right: 20.0),                            
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildButton() => Opacity(
    opacity: _shouldShow || contacts.length == 0 ? 1 : 0, 
    child: FloatingActionButton(
      onPressed: () {
        getContacts().then((response) {
          setState(() {
            contacts = response;
            if (response.length != 0) {
              _shouldShow = false;
              displayContacts.addAll(contacts);
            }                
          });
        });
      },        
      child: Icon(Icons.download_outlined),
      backgroundColor: Colors.pink,
    ),
  );
}

