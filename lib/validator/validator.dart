// Email Validation Function

bool validateEmailAddress(String email) {
  const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  if (RegExp(emailRegex).hasMatch(email)) {
    return true;
  } else {
    return false;
  }
}

// Username Validation Function

bool validateUsername(String username) {
  const usernameRegex = r'^[A-Za-z]+(?: [A-Za-z]+)*$';
  if (RegExp(usernameRegex).hasMatch(username)) {
    return true;
  } else {
    return false;
  }
}

// Password Validation Function

bool validatePassword(String password) {
  const passwordRegex =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$';
  if (RegExp(passwordRegex).hasMatch(password)) {
    return true;
  } else {
    return false;
  }
}
