// Copyright 2016 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <ctime>
#include <sstream>
#include <string>

#include "firebase/app.h"
#include "firebase/auth.h"
#include "firebase/util.h"

// Thin OS abstraction layer.
#include "main.h"  // NOLINT

using ::firebase::App;
using ::firebase::AppOptions;
using ::firebase::Future;
using ::firebase::FutureBase;
using ::firebase::auth::Auth;
using ::firebase::auth::Credential;
using ::firebase::auth::AuthError;
using ::firebase::auth::kAuthErrorNone;
using ::firebase::auth::kAuthErrorFailure;
using ::firebase::auth::EmailAuthProvider;
using ::firebase::auth::FacebookAuthProvider;
using ::firebase::auth::GitHubAuthProvider;
using ::firebase::auth::GoogleAuthProvider;
using ::firebase::auth::TwitterAuthProvider;
using ::firebase::auth::User;
using ::firebase::auth::UserInfoInterface;

// Constants used during tests.
//CHANGE THESE, ONLY USE FOR GUIDANCE
static const char kTestPassword[] = "testEmailPassword123";
static const char kTestEmailBad[] = "bad.test.email@example.com";
static const char kTestPasswordBad[] = "badTestPassword";
static const char kTestIdTokenBad[] = "bad id token for testing";
static const char kTestAccessTokenBad[] = "bad access token for testing";
static const char kTestPasswordUpdated[] = "testpasswordupdated";

static const char kFirebaseProviderId[] =
#if defined(__ANDROID__)
    "firebase";
#else   // !defined(__ANDROID__)
    "Firebase";
#endif  // !defined(__ANDROID__)

const char* email() const { return email_.c_str(); }
  const char* password() const { return password_.c_str(); }
  User* user() const { return user_; }
  void set_email(const char* email) { email_ = email; }
  void set_password(const char* password) { password_ = password; }

 private:
  Auth* auth_;
  std::string email_;
  std::string password_;
  User* user_;
  bool log_errors_;
};

#if defined(__ANDROID__)
  app = App::Create(GetJniEnv(), GetActivity());
#else
  app = App::Create();
#endif  // defined(__ANDROID__)

  LogMessage("Created the Firebase app %x.",
             static_cast<int>(reinterpret_cast<intptr_t>(app)));
  // Create the Auth class for that App.

  ::firebase::ModuleInitializer initializer;
  initializer.Initialize(app, nullptr, [](::firebase::App* app, void*) {
    ::firebase::InitResult init_result;
    Auth::GetAuth(app, &init_result);
    return init_result;
  });
  while (initializer.InitializeLastResult().status() !=
         firebase::kFutureStatusComplete) {
    if (ProcessEvents(100)) return 1;  // exit if requested
  }

  if (initializer.InitializeLastResult().error() != 0) {
    LogMessage("Failed to initialize Auth: %s",
               initializer.InitializeLastResult().error_message());
    ProcessEvents(2000);
    return 1;
  }

  Auth* auth = Auth::GetAuth(app);

  LogMessage("Created the Auth %x class for the Firebase app.",
             static_cast<int>(reinterpret_cast<intptr_t>(auth)));

  // It's possible for current_user() to be non-null if the previous run
  // left us in a signed-in state.
  if (auth->current_user() == nullptr) {
    LogMessage("No user signed in at creation time.");
  } else {
    LogMessage("Current user %s already signed in, so signing them out.",
               auth->current_user()->display_name().c_str());
    auth->SignOut();
  }


// Don't return until `future` is complete.
// Print a message for whether the result mathes our expectations.
// Returns true if the application should exit.
static bool WaitForFuture(FutureBase future, const char* fn,
                          AuthError expected_error, bool log_error = true) {
  // Note if the future has not be started properly.
  if (future.status() == ::firebase::kFutureStatusInvalid) {
    LogMessage("ERROR: Future for %s is invalid", fn);
    return false;
  }

  // Wait for future to complete.
  LogMessage("  Calling %s...", fn);
  while (future.status() == ::firebase::kFutureStatusPending) {
    if (ProcessEvents(100)) return true;
  }

  // Log error result.
  if (log_error) {
    const AuthError error = static_cast<AuthError>(future.error());
    if (error == expected_error) {
      const char* error_message = future.error_message();
      if (error_message) {
        LogMessage("%s completed as expected", fn);
      } else {
        LogMessage("%s completed as expected, error: %d '%s'", fn, error,
                   error_message);
      }
    } else {
      LogMessage("ERROR: %s completed with error: %d, `%s`", fn, error,
                 future.error_message());
    }
  }
  return false;
}

static bool WaitForSignInFuture(Future<User*> sign_in_future, const char* fn,
                                AuthError expected_error, Auth* auth) {
  if (WaitForFuture(sign_in_future, fn, expected_error)) return true;

  const User* const* sign_in_user_ptr = sign_in_future.result();
  const User* sign_in_user =
      sign_in_user_ptr == nullptr ? nullptr : *sign_in_user_ptr;
  const User* auth_user = auth->current_user();

  if (sign_in_user != auth_user) {
    LogMessage("ERROR: future's user (%x) and current_user (%x) don't match",
               static_cast<int>(reinterpret_cast<intptr_t>(sign_in_user)),
               static_cast<int>(reinterpret_cast<intptr_t>(auth_user)));
  }

  return false;
}

// Create an email that will be different from previous runs.
// Useful for testing creating new accounts.
static std::string CreateNewEmail() {
  std::stringstream email;
  email << "random_" << std::time(0) << "@gmail.com";
  return email.str();
}

static void ExpectFalse(const char* test, bool value) {
  if (value) {
    LogMessage("ERROR: %s is true instead of false", test);
  } else {
    LogMessage("%s is false, as expected", test);
  }
}

static void ExpectTrue(const char* test, bool value) {
  if (value) {
    LogMessage("%s is true, as expected", test);
  } else {
    LogMessage("ERROR: %s is false instead of true", test);
  }
}

// Log results of a string comparison for `test`.
static void ExpectStringsEqual(const char* test, const char* expected,
                               const char* actual) {
  if (strcmp(expected, actual) == 0) {
    LogMessage("%s is '%s' as expected", test, actual);
  } else {
    LogMessage("ERROR: %s is '%s' instead of '%s'", test, actual, expected);
  }
}

class AuthStateChangeCounter : public firebase::auth::AuthStateListener {
 public:
  AuthStateChangeCounter() : num_state_changes_(0) {}

  virtual void OnAuthStateChanged(Auth* auth) { num_state_changes_++; }

  void CompleteTest(const char* test_name, int expected_state_changes) {
    CompleteTest(test_name, expected_state_changes, expected_state_changes);
  }

  void CompleteTest(const char* test_name, int min_state_changes,
                    int max_state_changes) {
    const bool success = min_state_changes <= num_state_changes_ &&
                         num_state_changes_ <= max_state_changes;
    LogMessage("%sAuthStateListener called %d time%s on %s.",
               success ? "" : "ERROR: ", num_state_changes_,
               num_state_changes_ == 1 ? "" : "s", test_name);
    num_state_changes_ = 0;
  }

 private:
  int num_state_changes_;
};

// Utility class for holding a user's login credentials.
class UserLogin {
 public:
  UserLogin(Auth* auth, const std::string& email, const std::string& password)
      : auth_(auth),
        email_(email),
        password_(password),
        user_(nullptr),
        log_errors_(true) {}

  explicit UserLogin(Auth* auth) : auth_(auth) {
    email_ = CreateNewEmail();
    password_ = kTestPassword;
  }

  ~UserLogin() {
    if (user_ != nullptr) {
      log_errors_ = false;
      Delete();
    }
  }

  void Register() {
    Future<User*> register_test_account =
        auth_->CreateUserWithEmailAndPassword(email(), password());
    WaitForSignInFuture(register_test_account,
                        "CreateUserWithEmailAndPassword() to create temp user",
                        kAuthErrorNone, auth_);
    user_ = register_test_account.result() ? *register_test_account.result()
                                           : nullptr;
  }

  void Login() {
    Credential email_cred =
        EmailAuthProvider::GetCredential(email(), password());
    Future<User*> sign_in_cred = auth_->SignInWithCredential(email_cred);
    WaitForSignInFuture(sign_in_cred,
                        "Auth::SignInWithCredential() for UserLogin",
                        kAuthErrorNone, auth_);
  }

  void Delete() {
    if (user_ != nullptr) {
      Future<void> delete_future = user_->Delete();
      if (delete_future.status() == ::firebase::kFutureStatusInvalid) {
        Login();
        delete_future = user_->Delete();
      }

      WaitForFuture(delete_future, "User::Delete()", kAuthErrorNone,
                    log_errors_);
    }
    user_ = nullptr;
  }

