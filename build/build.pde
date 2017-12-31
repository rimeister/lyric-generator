import controlP5.*;
import rita.*;

ControlP5 cp5;
Textarea inputTextArea; 
String myText = "Input text goes here";

void setup() {
	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
	cp5 = new ControlP5(this);

 	inputTextArea = cp5
 		.addTextarea("txt")
		.setPosition(15,15)
		.setSize(230,height)
		.setFont(createFont("arial",12))
		.setLineHeight(14)
		.setColor(color(128))
		.setColorBackground(color(255,100))
		.setColorForeground(color(255,100));
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

	if(keyPressed && key==' ') {
		inputTextArea.scroll((float)mouseX/(float)width);
	}
	if(keyPressed && key=='l') {
		inputTextArea.setLineHeight(mouseY);
	}

}

void keyPressed() {
  if(key=='r') {
    inputTextArea.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		+" Quisque sed velit nec eros scelerisque adipiscing vitae eu sem."
		+" Quisque malesuada interdum lectus. Pellentesque pellentesque molestie"
		+" vestibulum. Maecenas ultricies, neque at porttitor lacinia, tellus enim"
		+" suscipit tortor, ut dapibus orci lorem non ipsum. Mauris ut velit velit."
		+" Fusce at purus in augue semper tincidunt imperdiet sit amet eros."
		+" Vestibulum nunc diam, fringilla vitae tristique ut, viverra ut felis."
		+" Proin aliquet turpis ornare leo aliquam dapibus. Integer dui nisi, condimentum"
		+" ut sagittis non, fringilla vestibulum sapien. Sed ullamcorper libero et massa"
		+" congue in facilisis mauris lobortis. Fusce cursus risus sit amet leo imperdiet"
		+" lacinia faucibus turpis tempus. Pellentesque pellentesque augue sed purus varius"
		+" sed volutpat dui rhoncus. Lorem ipsum dolor sit amet, consectetur adipiscing elit"
	);
                      
  } else if(key=='c') {
    inputTextArea.setColor(0xffffffff);
  }
}