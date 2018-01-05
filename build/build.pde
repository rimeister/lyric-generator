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
	int id; 

	Word(String tempValue, int tempSyllableCount, int tmpId) {
		value = tempValue;
		syllableCount = tempSyllableCount;
		id = tmpId;
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

	inputTextArea.setText("Sunset is the time of day when our sky meets the outer space solar winds. There are blue, pink, and purple swirls, spinning and twisting, like clouds of balloons caught in a blender. The sun moves slowly to hide behind the line of horizon, while the moon races to take its place in prominence atop the night sky. People slow to a crawl, entranced, fully forgetting the deeds that still must be done. There is a coolness, a calmness, when the sun does set."
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
	ArrayList<Word> wordsArray = new ArrayList<Word>();

	generatedLyrics = "";

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

		Word currentWord = new Word(currentWordValue,currentWordSyllablesCount,y);

		wordsArray.add(currentWord);
		
	}

	//for (int i = 0; i < numberOfStanzas; i++) {

		String currentStanza = "";

		for (int x = 0; x < numberOfLinesPerStanza; x++) {

			String currentLine = "";
			int j = numberOfSyllablesPerLine;

			// Randomly get a word from the array that has a syllableCount of less than or equal to "j" ( same as numberOfSyllablesPerLine -- 4, in this case)
			// Add that word to currentLine var using += operator
			// Reduce j var by number of syllables in the word added to line
			// Find a new random word from the array with a syllableCount of less than or equal to what ever "j" is currently worth
			// Repeat until J = 0

			while (j > 0) {

				Word[] filterWordResults = new Word[0];
				String wordToAdd;
				int randomIndex;
				int indexOfRemoved;

				for (Word word : wordsArray) {
					
					if ( word.syllableCount <= j && !RiTa.isPunctuation(word.value) ) {
						filterWordResults = (Word[]) append(filterWordResults, word);
					}

				}

				if (filterWordResults.length > 0) {

					randomIndex = int( random(filterWordResults.length) );

					if (currentLine != "") {
						currentLine += " "; 					
					}

					currentLine += filterWordResults[randomIndex].value;

					j -= filterWordResults[randomIndex].syllableCount;

					indexOfRemoved = getIndexOfRemoved(wordsArray,filterWordResults[randomIndex]);

					wordsArray.remove(indexOfRemoved);

				} else {

					break;

				}
				
			}

			// Add "\n" to end of current line using "currentLine += '\n' "
			currentLine += "\n";
			currentStanza += currentLine;

		}

		// Add "\n" to end of current stanza using "currentStanza += '\n' "
		// Add currentStanza to var generatedLyrics
		currentStanza += "\n" + " " + "\n";
		generatedLyrics += currentStanza;

		//println(wordsArray);

	//}

	// Show Generated lyrics in output text box
	outputTextArea.setText(generatedLyrics);
}

int getIndexOfRemoved(ArrayList<Word> wordsToUpdate, Word selectedWord){

	int indexVal = 0;

	for (int k = 0; k < wordsToUpdate.size(); k++) {

		if (wordsToUpdate.get(k).id == selectedWord.id) {
			indexVal = k;
			break;
		}
	
	}

	return indexVal;

}
// Ideas for next steps: Rhyme scheme. Evaluate if word at the end of a line rhymes with another word (from Array for Words). If there is at least one match, randomly choose one of the rhyming words, with the correct number of syllables. If not, randomly choose a word that rhymes and correct correct number of syllables from the dictionary/lexicon.
// UI design: number of syllables per line, number of lines per stanza, rhyme scheme, perfect or imperect rhymes, meter (e.g., iambic)