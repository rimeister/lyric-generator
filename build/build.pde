import g4p_controls.*;
import rita.*;

GTextArea inputTextArea;
GTextArea outputTextArea;
GButton generateLyricsBtn;
GButton clearBtn;
PFont arialFont;
String inputText;
String generatedLyrics;
RiString rInputText;
int numberOfStanzas = 4;
int numberOfLinesPerStanza = 4;
int numberOfSyllablesPerLine = 4;

class Word {

	// Word object has a value (the word itself), and number of syllables
	String value;
	int syllableCount;

	Word(String tempValue, int tempSyllableCount) {
		value = tempValue;
		syllableCount = tempSyllableCount;
	}

}

void setup() {

	//GCScheme.changePaletteColor(8, 8, color(0, 0, 255));
	G4P.setGlobalColorScheme(8);
	size(1000, 500);
	textAlign(LEFT, TOP);
	textSize(12);
	fill(0);
	noStroke();
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
	clearBtn = new GButton(this, 15, 455, 150, 30, "Clear");

	outputTextArea = new GTextArea(this, 275, 15, 725, height, G4P.SCROLLBARS_VERTICAL_ONLY | G4P.SCROLLBARS_AUTOHIDE);
}

void draw() {

	// Set background
	background(255);
	fill(0);

	// Draw dividing line
 	stroke(175);
 	line(260,0,260,height);

}

void handleButtonEvents(GButton button, GEvent event){

	if (button == generateLyricsBtn) {
		generateLyrics();		
	}

	else if (button == clearBtn) {
		outputTextArea.setText("");
	}

}

void generateLyrics(){

	String[] wordsFromInput = new String[0];
	Word[] wordsArray = new Word[0];


	// Get text from text area
	inputText = inputTextArea.getText();

	// Convert that text to a RiTa string
	rInputText = new RiString(inputText);

	// Put the words into an array
	wordsFromInput = rInputText.words();

	// Get the number of words in the array
	int numberOfWords = wordsFromInput.length;

	// Put create a Word object for each word, put it into the wordsArray
	for (int y = 0; y < numberOfWords; y++) {

		String currentWordValue = wordsFromInput[y];
		String currentWordSyllables = RiTa.getSyllables(currentWordValue);
		String[] currentSyllablesArray = split(currentWordSyllables,"/");
		int currentWordSyllablesCount = currentSyllablesArray.length;

		Word currentWord = new Word(currentWordValue,currentWordSyllablesCount);

		append(wordsArray,currentWord);

		println(currentWord.value);
		println(currentWord.syllableCount);

	}

	for (int i = 0; i < numberOfStanzas; i++) {

		String currentStanza;

		for (int x = 0; x < numberOfLinesPerStanza; x++) {

			String currentLine;
			int j = numberOfSyllablesPerLine;

			while (j > 0) {



			}

		}

	}


//	generatedLyrics = rInputText.get("syllables");

	//print();

	outputTextArea.setText(generatedLyrics);
}