import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';

class ContactElement extends StatefulWidget {

  final Contact contact;
  ContactElement({Key key, @required this.contact}) : super(key: key);

  @override
  _ContactElementState createState() => _ContactElementState();
}

class _ContactElementState extends State<ContactElement> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  bool _enabled = false;

  @override
  void initState() {        
    nameController.text = widget.contact.name;   
    phoneController.text = widget.contact.phone;   
  }   

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      resizeToAvoidBottomPadding: false, 
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Contact detail'),
      ),    
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              _buildLogo(),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() => Card(            
    elevation: 0,
    margin: EdgeInsets.only(top: 60.0),
    child: Image.asset(
      'assets/images/user.png',
      fit: BoxFit.cover,
    )
  );

  Widget _buildForm() => Form(
    key: _formKey,
    child: Container(
      padding: EdgeInsets.only(left: 35, right: 35, top: 50),  
      child: Column(      
        children: <Widget>[
          TextFormField(
            enabled: _enabled, 
            autofocus: false,
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(
                color: Colors.black,
                height: 1.5,   
                fontSize: 16,
                fontWeight: FontWeight.w400,        
              ),
              hintText: "Enter name",
              hintStyle: TextStyle(
                height: 2
              ),
            ),
            controller: nameController,    
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter name';
              }
              return null;
            },                                    
          ),
          TextFormField(
            enabled: _enabled, 
            autofocus: false,
            decoration: InputDecoration(
              labelText: "Phone number",
              labelStyle: TextStyle(
                color: Colors.black,
                height: 1.5,   
                fontSize: 16,
                fontWeight: FontWeight.w400,               
              ),
              hintText: "Enter password",
              hintStyle: TextStyle(
                height: 2
              ),
            ),
            controller: phoneController,                        
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(  
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text(_enabled ? "Confirm edit  " : "Edit  ", style: TextStyle(fontSize: 16)),
                      Icon(Icons.edit),
                    ],
                  ),
                ),   
                onPressed: () {
                  setState(() {                    
                    if (_enabled) {
                      if (_formKey.currentState.validate()) {
                        var currentContact = widget.contact;                      
                        currentContact.name = nameController.text;
                        currentContact.phone = phoneController.text;
                        Navigator.pop(context, widget.contact);     
                      }                       
                    }
                    _enabled = !_enabled;
                  });
                },  
                color: Colors.grey[200],  
                textColor: Colors.black,  
                padding: EdgeInsets.all(8.0),  
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              RaisedButton(  
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text("Delete  ", style: TextStyle(fontSize: 16)),
                      Icon(Icons.delete_forever),
                    ],
                  ),
                ),  
                onPressed: () {                  
                  Navigator.pop(context, widget.contact.name);              
                },  
                color: Colors.grey[200], 
                textColor: Colors.black,  
                padding: EdgeInsets.all(8.0),  
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ],
          ),
        ],
      ),
    ),    
  );
}