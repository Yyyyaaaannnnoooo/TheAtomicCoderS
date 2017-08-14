// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

//function to load binary and return an image
PImage loadIcon(String thePath, String binToLoad, color c1, color c2) {
  String[] loadedIcon = loadStrings(thePath +"/"+ binToLoad);
  int num = 50;
  PImage img = createImage(num, num, ARGB);
  img.loadPixels();
  for (int x = 0; x < img.width; x ++) {
    for (int y = 0; y < img.height; y ++) {
      int index = x + img.width * y;
      //if(int(loadedIcon[index]) == 0)img.pixels[index] = color(255, 255);
      img.pixels[index] = int(loadedIcon[index]) == 0 ? c1 : c2;
    }
  }
  img.updatePixels();
  return img;
}