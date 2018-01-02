import controlP5.*;
import rita.*;

ControlP5 cp5;
Textarea inputTextArea; 

void setup() {

	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
	cp5 = new ControlP5(this);

	inputTextArea = cp5
	 	.addTextarea("inputTxt")
	 	.setPosition(15,15)
	 	.setSize(230,height)
	 	.setFont(createFont("arial",12))
	 	.setLineHeight(14)
	 	.setColor(0)
	 	.setColorBackground(color(255,100))
	 	.setColorForeground(color(255,100))
	;

	inputTextArea.setText("Lorem Ipsum is simply dummy text of the printing and typesetting"
	    +" industry. Lorem Ipsum has been the industry's standard dummy text"
	    +" ever since the 1500s, when an unknown printer took a galley of type"
	    +" and scrambled it to make a type specimen book. It has survived not"
	    +" only five centuries, but also the leap into electronic typesetting,"
	    +" remaining essentially unchanged. It was popularised in the 1960s"
	    +" with the release of Letraset sheets containing Lorem Ipsum passages,"
	    +" and more recently with desktop publishing software like Aldus"
	    +" PageMaker including versions of Lorem Ipsum."
	);

}

void draw() {

	// Set background
	background(255);
	fill(0);

	// Draw dividing line
 	stroke(175);
 	line(230,0,230,height);

}