

String passArrayToString(List<String> list){
  String text="";
  if(list.isEmpty){
   return "";
  }
  else if(list.length==1){
    return list[0];
  }
  else{
    for(var element = 0; element<list.length-1; element++){
      text+= "${list[element]}, ";
    }
    text+= list[list.length-1];
  }
  return text;
}