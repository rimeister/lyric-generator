import controlP5.*;
import rita.*;

ControlP5 cp5;
Textarea inputTextarea; 
String myText = "Input text goes here";

void setup() {
	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
	cp5 = new ControlP5(this);

	 inputTextarea = cp5
	 	.addTextarea("inputTxt")
	 	.setPosition(400,400)
	 	.setSize(100,50)
	 	.setFont(createFont("arial",12))
	 	.setColor(255)
	 	.setColorBackground(color(255,100))
	 	.setColorForeground(color(255,100))
	;

}

void draw() {
	// Set background
	background(255);
	fill(0);

	// Draw dividing line
 	stroke(175);
 	line(230,0,230,height);
}