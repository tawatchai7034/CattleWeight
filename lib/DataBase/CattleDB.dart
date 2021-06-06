import 'ProfileDB.dart';
class CattleDB extends ProfileDB{
  late int _cattleNumber;
  late String _cattleName;
  late String _gender;
  late String _specise;
  late double _heartGirth;
  late double _bodyLenght;
  late double _weight;
  late String _img;

  CattleDB(int cattleNumber, String cattleName,String gender,String specise,String img,double heartGirth,
  double bodyLenght,double weight):super(cattleNumber,cattleName,gender,specise,img);

  void cattleSetter(double heartGirth,double bodyLenght,double weight,String img){
    this._cattleNumber = super.getCattleNumber();
    this._cattleName = super.getCattleName();
    this._gender = super.getGender();
    this._specise = super.getSpecise();
    this._heartGirth = heartGirth;
    this._bodyLenght = bodyLenght;
    this._weight = weight;
    this._img = img;
  }
  
  // Getter
  String getImg(){
    return this._img;
  }

  double getHeartGirth(){
    return this._heartGirth;
  }

  double getBodyLenght(){
    return this._bodyLenght;
  }

  double getWeight(){
    return this._weight;
  }

  // Setter
  void setHeartGirth(double heartgirth){
    this._heartGirth = heartgirth;
  }

  void setBodyLenght(double bodyLenght){
    this._bodyLenght = bodyLenght;
  }

  void setWeight(double weight){
    this._weight = weight;
  }

  void setImg(String img){
    this._img = img;
  }

  void showdata(){
    print("CattleDB");
    print("Cattle number : $_cattleNumber");
    print("Cattle name : $_cattleName");
    print("Gender : $_gender");
    print("Specise : $_specise");
    print("Heart girth : $_heartGirth");
    print("Body Lenght : $_bodyLenght");
    print("Weight : $_weight");
    print("Image : $_img");

  }


}