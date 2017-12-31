import rita.*;

String myText = "Input text goes here";

void setup() {
	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
}

void draw() {
	background(255);
	fill(0);

	text(myText, 15, 15, 200, height);	

 	stroke(175);
 	line(230,0,230,height);

}

void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (myText.length() > 0) {
      myText = myText.substring(0, myText.length()-1);
    }
  } else if (keyCode == DELETE) {
    myText = "";
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
    myText = myText + key;
  }
}