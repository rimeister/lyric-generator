import controlP5.*;
import rita.*;

ControlP5 cp5;
Textarea inputTextArea;
Button submitBtn;
PFont arialFont;
String inputText;

void setup() {

	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
	cp5 = new ControlP5(this);
	arialFont = createFont("arial",12);

	inputTextArea = cp5
	 	.addTextarea("inputTxtArea")
	 	.setPosition(15,15)
	 	.setSize(230, (height - 100) )
	 	.setFont(arialFont)
	 	.setLineHeight(14)
	 	.setColor(0)
	 	.setColorBackground(color(255,100))
	 	.setColorForeground(color(255,100))
	;

	inputTextArea.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
		+"Donec placerat risus vitae mi pharetra tempus. Nullam feugiat facilisis iaculis. "
		+"In cursus nulla augue, quis bibendum nibh finibus rhoncus. Aenean sit amet feugiat "
		+"nunc. Sed quis suscipit lacus. Ut venenatis ipsum lectus, eu interdum lorem varius "
		+"eget. Nulla facilisi. Ut ultricies, lectus et venenatis iaculis, risus ex placerat "
		+"risus, vel viverra tortor erat ac quam. Sed porttitor tortor cursus, porta neque nec, "
		+"consequat lacus. Vestibulum varius quam ut turpis venenatis, vel dictum eros suscipit. "
		+"Integer ac leo pretium, fermentum nisl vel, dapibus felis. Duis quis justo ut diam viverra "
		+"tempor. Aliquam vehicula ultrices purus, vitae pulvinar mauris sollicitudin eu. Aenean "
		+"elementum ipsum quis eros lacinia vestibulum. Ut dignissim tellus a dui bibendum faucibus. "
		+"Sed vitae eros ac lorem elementum pretium at et lectus."
		+"\n"
		+"Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; "
		+"Fusce venenatis ultrices egestas. Nulla facilisi. Sed egestas lacinia sodales. Etiam mollis "
		+"tellus at sem finibus rutrum. Mauris efficitur sem vel felis vehicula, ut consectetur nisi "
		+"placerat. Fusce interdum augue non volutpat maximus. Phasellus feugiat sollicitudin neque vel "
		+"ornare. "
	);

	submitBtn = cp5
		.addButton("generateLyrics")
		.setCaptionLabel("Generate Lyrics")
	 	.setFont(arialFont)
		.setPosition(15, 425)
		.setSize(150,30)
		.setColorBackground(color(#53525b))
	;

}

void draw() {

	// Set background
	background(255);
	fill(0);

	// Draw dividing line
 	stroke(175);
 	line(260,0,260,height);

}
void generateLyrics(){
	inputText = inputTextArea.getText();
	print("The text you typed is :");
	print(inputText);
}