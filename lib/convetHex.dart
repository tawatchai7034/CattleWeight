class ConvertHex{

   int hexColor(String hexCode) {
    String newColor = '0xff' + hexCode;
    newColor = newColor.replaceAll('#', '');
    int colorCode = int.parse(newColor);
    return colorCode;
  }

}