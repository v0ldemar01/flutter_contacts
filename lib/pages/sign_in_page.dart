import 'package:flutter/material.dart';
import 'package:flutter_contacts/utils/fetch/loadUser.dart';
import 'package:flutter_contacts/utils/validate/email.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {  

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _passwordVisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: _buildMain(),
        decoration: new BoxDecoration(color: Colors.white),
      ),
    );
  }

  Widget _buildMain() => ListView(
    children: [
      _buildLogo(),
      Center(
        child: Text(
          'Voldemar Inc',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(40.0),        
        child: Column(
          children: <Widget>[
            _buildGreeting(),
            _buildForm(),
          ],
        ),
      ),
    ],
  );

  Widget _buildLogo() => Container(
    child: Card(
      margin: const EdgeInsets.only(top: 20.0, left: 125.0, right: 125.0),
      elevation: 0,
      child: Image.asset(
        'assets/images/cloud.png',
        fit: BoxFit.cover,
      )
    ),
  );

  Widget _buildGreeting() => ListTile(
    title: Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
      ),
    ),
    subtitle: Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        'Hi there! Nice to see you again'
      ),
    ),    
  );  

  Widget _buildForm() => Form(
    key: _formKey,
    child: Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),  
      child: Column(      
        children: <Widget>[
          TextFormField(
            autofocus: false,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                color: Colors.red,
                height: 1.0,   
                fontSize: 18.0,
                fontWeight: FontWeight.w500,        
              ),
              hintText: "Enter email",
              hintStyle: TextStyle(
                height: 2
              ),
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
          TextFormField(
            autofocus: false,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(
                color: Colors.red,
                height: 1.5,   
                fontSize: 18,
                fontWeight: FontWeight.w500,               
              ),
              hintText: "Enter password",
              hintStyle: TextStyle(
                height: 2.5
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _passwordVisible = true;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      _passwordVisible = false;
                    });
                  },
                  child: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            controller: passwordController,
            obscureText: !_passwordVisible,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 25.0),
          MaterialButton(
            onPressed: _handleSignIn,
            textColor: Colors.white,
            color: Color.fromRGBO(232, 105, 110, 1.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(                  
                  fontSize: 16.0,
                ),
              ),
            ),
            height: 45.0,
            minWidth: 600.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ],
      ),
    ),    
  );

  void _handleSignIn() async{       
    if (_formKey.currentState.validate()) {
      var thisUser = await readJson();      
      if (thisUser['email'] == emailController.text && thisUser['password'] == passwordController.text)
        Navigator.pushReplacementNamed(context, '/contacts');
    }  
  }
}