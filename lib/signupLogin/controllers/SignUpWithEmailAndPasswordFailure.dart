//
// class SignUpWithEmailAndPasswordFailure {
//   final String message;
//
//   const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);
//
//   factory SignUpWithEmailAndPasswordFailure.code(String code){
//     switch(code){
//       case 'weak-password' :
//         return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password.');
//       case 'invalid-email' :
//         return const SignUpWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
//       case 'email-already-in-allowed':
//         return const SignUpWithEmailAndPasswordFailure('An account already exists for that email.');
//       case 'operation-not-allowed':
//         return const SignUpWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help');
//       default:
//         return const SignUpWithEmailAndPasswordFailure();
//
//     }
//   }
// }