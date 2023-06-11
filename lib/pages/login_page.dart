import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/widgets/card_container.dart';
import 'package:productos_app/widgets/fondo_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('Iniciar sesión',
                    style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm()
                      ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Text('Crea una nueva cuenta',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
child: Form(
  key: loginForm.formKey,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  child: Column(
    children: [
      TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),
          ),
          hintText: 'juan.perez@gmail.com',
          labelText: 'Correo electrónico:',
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.alternate_email_sharp,
            color: Colors.deepPurple,
          ),
        ),
        onChanged: (value) => loginForm.email = value,
        validator: (value) {
          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = new RegExp(pattern);
          return regExp.hasMatch(value ?? '')
          ? null
          : 'El correo no es válido';
        },
      ),
      TextFormField(
        autocorrect: false,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),
          ),
          hintText: '***********',
          labelText: 'Contraseña:',
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.deepPurple,
          ),
        ),
        onChanged: (value) => loginForm.password = value,
        validator: (value) {
          if(value != null && value.length >= 6) return null;
          return 'La contraseña debe ser de al menos 6  caracteres';
        },
      ),
      SizedBox(height: 30,),
      MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        disabledColor: Colors.grey,
        color: Colors.deepPurple,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 15,
          ),
          child: Text(
            loginForm.isLoading ? 'Espere...'
            : 'Ingresar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onPressed: loginForm.isLoading 
          ? null
          : () async {
            FocusScope.of(context).unfocus(); //quitar teclado
            if(!loginForm.isValidForm()) return;
            loginForm.isLoading = true;
            //Navigator.pushReplacementNamed(context, 'home');
            await Future.delayed(Duration(seconds: 2));
            loginForm.isLoading = false;
            Navigator.pushReplacementNamed(context, 'home');
          },
      ),
    ],
  ),
),
    );
  }
}




