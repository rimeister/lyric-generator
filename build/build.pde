import g4p_controls.*;
import rita.*;

GTextArea inputTextArea;
GButton generateLyricsBtn;
PFont arialFont;
String inputText;

void setup() {

	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
	arialFont = createFont("arial",12);

	inputTextArea = new GTextArea(this, 15, 15, 230, 400, G4P.SCROLLBARS_VERTICAL_ONLY | G4P.SCROLLBARS_AUTOHIDE);

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
		+"\n"
		+"Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; "
		+"Fusce venenatis ultrices egestas. Nulla facilisi. Sed egestas lacinia sodales. Etiam mollis "
		+"tellus at sem finibus rutrum. Mauris efficitur sem vel felis vehicula, ut consectetur nisi "
		+"placerat. Fusce interdum augue non volutpat maximus. Phasellus feugiat sollicitudin neque vel "
		+"ornare. "
	);

	// generateLyricsBtn bg color: #53525b
	generateLyricsBtn = new GButton(this, 15, 425, 150, 30, "Generate Lyrics");

}

void draw() {

	// Set background
	background(255);
	fill(0);

	// Draw dividing line
 	stroke(175);
 	line(260,0,260,height);

}
// void generateLyrics(){
// 	inputText = inputTextArea.getText();
// 	print("The text you typed is :");
// 	print(inputText);
// }