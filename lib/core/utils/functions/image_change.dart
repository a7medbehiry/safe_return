import 'package:rxdart/rxdart.dart';

final imageChanged =   BehaviorSubject<String>();

addImage(String image){
  imageChanged.add(image);
}