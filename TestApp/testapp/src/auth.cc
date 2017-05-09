//
// Created by Gavin on 9/05/2017.
//

public CreateNewUser(email, password){
        firebase::Future<firebase::auth::User*> result = auth->CreateUserWithEmailAndPassword(email, password);

        firebase::Future<firebase::auth::User*> result =
            auth->CreateUserWithEmailAndPasswordLastResult();

        // The lambda has the same signature as the callback function.
        result.OnCompletion(
            [](const firebase::Future<firebase::auth::User*>& result,
               void* user_data) {
              // `user_data` is the same as &my_program_context, below.
              // Note that we can't capture this value in the [] because std::function
              // is not supported by our minimum compiler spec (which is pre C++11).
              MyProgramContext* program_context =
                  static_cast<MyProgramContext*>(user_data);

              // Process create user result...
              (void)program_context;
            },
            &my_program_context);
}

public SignInUser(email, password){
        firebase::Future<firebase::auth::User*> result = auth->SignInWithEmailAndPassword(email, password);
}

public SignOutUser(){
    if(auth->current_user != nullptr){
        auth->SignOut();
    } else {
        LogMessage("ERROR: User failed to logout : current_user = nullptr");
    }
}

//listenes to sign-in and sign-out events. Updates fields accordingly.
class MyAuthStateListener : public firebase::auth::AuthStateListener {
 public:
  void OnAuthStateChanged(firebase::auth::Auth* auth) override {
    firebase::auth::User* user = auth->current_user();
    if (user != nullptr) {
      // User is signed in
      printf("OnAuthStateChanged: signed_in %s\n", user->uid().c_str());
      const std::string displayName = user->DisplayName();
      const std::string emailAddress = user->Email();
    } else {
      // User is signed out
      printf("OnAuthStateChanged: signed_out\n");
    }
    // ...
  }
};



