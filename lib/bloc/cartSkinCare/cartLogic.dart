import 'package:bloc/bloc.dart';
import 'cartState.dart';

class Cartlogic extends Cubit<Cartstate> {
  Cartlogic():super(InitCare());
  int i=1;
  void pcart(){
    i++;
    emit(PCart());
  }
  void mcart(){
    if(i>1)
    i--;
    emit(MCart());
  }

}