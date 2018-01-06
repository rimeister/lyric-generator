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
int numberOfLinesPerStanza = 4;
int numberOfSyllablesPerLine = 4;
int[] syllableStressPattern = {1,0};
boolean noMatchesLeft = false;
boolean syllablesLeft;


class Word {

	// Word object has a value (the word itself), and number of syllables
	String value;
	int id;

	public Word(String tempValue, int tmpId) {
		value = tempValue;
		id = tmpId;
	}

	public int[] getSyllableStresses() {

		ArrayList<Integer> syllablesArrayList = new ArrayList<Integer>();

		String currentWordStresses = RiTa.getStresses(value);

		String[] currentSyllablesArray = split(currentWordStresses,"/");

		int[] syllables = new int[currentSyllablesArray.length];

		for (int i = 0; i < currentSyllablesArray.length; i++) {
			syllables[i] = Integer.parseInt(currentSyllablesArray[i]);
		}

		return syllables;

	}

	public int getSyllableCount() {

		ArrayList<Integer> syllablesArrayList = new ArrayList<Integer>();

		String currentWordSyllables = RiTa.getSyllables(value);

		String[] currentSyllablesArray = split(currentWordSyllables,"/");

		int syllableCount = currentSyllablesArray.length;

		return syllableCount;
		
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

	// Create a Word object for each word, put it into the wordsArray. Runs once when Generate Lyrics button is pushed.
	for (int y = 0; y < numberOfWords; y++) {

		String currentWordValue = wordsFromInput[y];
		if (!RiTa.isPunctuation(currentWordValue)) {
			
			Word currentWord = new Word(currentWordValue,y);
			wordsArray.add(currentWord);
			
		}
		
	}

<<<<<<< HEAD
	if (wordsArray.size() > 0) {
		syllablesLeft = true;
	}

=======
>>>>>>> parent of 19f530b... Commented out contingency code for when it fails to find a match 3 times. Added the word BOSS anywhere fitsStressPattern evaluates to false. Program runs, but BOSS appears at all the fail spots
	do {

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
				int stressFailCount = 0;

				for (Word word : wordsArray) {
					// Filter so we get only words with the number of syllables we're looking for, and omit punctuationn.
					if ( word.getSyllableCount() <= j && !RiTa.isPunctuation(word.value) ) {
						filterWordResults = (Word[]) append(filterWordResults, word);
					}

				}

				if (filterWordResults.length > 0) {

					// Get a random index value based on the length of the results array
					randomIndex = int( random(filterWordResults.length) );
					
					// Get desired starting index by taking number of syllables, subtracting how many spaces are left, then subtract one to get index
					int startAtIndex = numberOfSyllablesPerLine - j;

					// Run function to see if current word matches the stress arrangement we're looking for. Returns 'true' if it does.
					boolean fitsStressPattern = testStressesAgaintPattern(filterWordResults[randomIndex],startAtIndex);
					
					if (fitsStressPattern) {

						// Add space if current line is not empty (i.e., there is already at least one word in it)
						if (currentLine != "") {
							currentLine += " "; 					
						}

						currentLine += filterWordResults[randomIndex].value;

						// Test to see syllables
						for (int i = 0; i < filterWordResults[randomIndex].getSyllableStresses().length; i++) {
							currentLine += filterWordResults[randomIndex].getSyllableStresses()[i];
						}
						
						j -= filterWordResults[randomIndex].getSyllableCount();

						indexOfRemoved = getIndexOfRemoved(wordsArray,filterWordResults[randomIndex]);

						wordsArray.remove(indexOfRemoved);

					} else {

						stressFailCount++;

					}

					if (stressFailCount == 3) {
						
						// If it fails to randomly find a match three times, systematically search all words of appropriate syllable length until you find one
						for (int i = 0; i < filterWordResults.length; i++) {
							
							boolean matchesStresses = testStressesAgaintPattern(filterWordResults[i],startAtIndex);
							if (matchesStresses) {

								if (currentLine != "") {
									currentLine += " "; 					
								}

								currentLine += filterWordResults[i].value;

								j -= filterWordResults[i].getSyllableCount();

								indexOfRemoved = getIndexOfRemoved(wordsArray,filterWordResults[i]);

								wordsArray.remove(indexOfRemoved);

								// After systematically finding a word and adding it to the current line, break out of the loop
								// By breaking out at this point, noMatchesLeft does not get set to true
								break;
							}
							// If it still can't find any matches, that means that there are none. Set var "no matches left" to true. 
							noMatchesLeft = true;
						}


					}


				}  else {

					syllablesLeft = false;
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

<<<<<<< HEAD
	} while (syllablesLeft); // End do-while loop
=======
	} while (!noMatchesLeft); // End do-while loop
>>>>>>> parent of 19f530b... Commented out contingency code for when it fails to find a match 3 times. Added the word BOSS anywhere fitsStressPattern evaluates to false. Program runs, but BOSS appears at all the fail spots

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

boolean testStressesAgaintPattern(Word wordToTest, int startingIndex) {
	
	int[] stressPattern = {1,0,1,0};

	int[] currentWordStresses = wordToTest.getSyllableStresses();

	for (int i = 0; i < currentWordStresses.length; i++) {
		if ( currentWordStresses[i] != stressPattern[startingIndex + i] ) {
			return false;
		}
	}

	return true;

}

// Ideas for next steps: Rhyme scheme. Evaluate if word at the end of a line rhymes with another word (from Array for Words). If there is at least one match, randomly choose one of the rhyming words, with the correct number of syllables. If not, randomly choose a word that rhymes and correct correct number of syllables from the dictionary/lexicon.
// UI design: number of syllables per line, number of lines per stanza, rhyme scheme, perfect or imperect rhymes, meter (e.g., iambic)