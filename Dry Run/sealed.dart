sealed class NetworkEvent {}

class Error extends NetworkEvent {}
class Loading extends NetworkEvent {}
class Success extends NetworkEvent {}


NetworkEvent getRandomNetworkState() {
  return Error();
}


void main(){
  final event = getRandomNetworkState();
  return switch(event){
    Error() => print("Error"),
    Loading() => print("Loading"),
    Success() => print("Success"),
  };
}

// Output: Error

