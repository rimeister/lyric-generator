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
int numberOfStanzas = 4;
int numberOfSyllablesPerLine = 4;
int[] syllableStressPattern = {1,0};
int testInt = 0;

class Word {

	// Word object has a value (the word itself), and number of syllables
	String value;
	int id;
	int[] stresses;
	int syllablecount;

	public Word(String tempValue, int tmpId, int[] tmpStresses, int tmpSyllablecount) {
		value = tempValue;
		id = tmpId;
		stresses = tmpStresses;
		syllablecount = tmpSyllablecount;
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

	inputTextArea.setText("Sunset is the time of day when our sky meets the outer space solar winds. There are blue, pink, and purple swirls, spinning and twisting, like clouds of balloons caught in a blender. The sun moves slowly to hide behind the line of horizon, while the moon races to take its place in prominence atop the night sky. People slow to a crawl, entranced, fully forgetting the deeds that still must be done. There is a coolness, a calmness, when the sun does set. Sunset is the time of day when our sky meets the outer space solar winds. There are blue, pink, and purple swirls, spinning and twisting, like clouds of balloons caught in a blender. The sun moves slowly to hide behind the line of horizon, while the moon races to take its place in prominence atop the night sky. People slow to a crawl, entranced, fully forgetting the deeds that still must be done. There is a coolness, a calmness, when the sun does set."
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
			int[] stressesArray = getSyllableStresses(currentWordValue);
			int sylCount = getSyllableCount(currentWordValue);			
			Word currentWord = new Word(currentWordValue,y,stressesArray,sylCount);
			wordsArray.add(currentWord);		
		}
		
	}

	for (int w = 0; w < numberOfStanzas; w++) {

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
				int startAtIndex = numberOfSyllablesPerLine - j;

				for (Word word : wordsArray) {

					// Filter so we get only words with the number of syllables we're looking for, and omit punctuationn.
					if ( word.syllablecount <= j && !RiTa.isPunctuation(word.value) ) {
						filterWordResults = (Word[]) append(filterWordResults, word);
					}

				}

				if (filterWordResults.length > 0) {

					// function that searches through results array and returns a word that matches stress pattern goes here
					Word wordToAdd = findWordThatMatchesStressPattern(filterWordResults, startAtIndex,j);
					currentLine += wordToAdd.value;

					// Add a space after if it's not the first word
					if (currentLine != "") {
						currentLine += " "; 					
					}

					// Reduce the remaining available syllables in the line by the number of syllables in the added word
					j -= wordToAdd.syllablecount;

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

	}

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

int[] getSyllableStresses(String wordVal) {

	ArrayList<Integer> syllablesArrayList = new ArrayList<Integer>();

	String currentWordStresses = RiTa.getStresses(wordVal);

	String[] currentSyllablesArray = split(currentWordStresses,"/");

	int[] syllables = new int[currentSyllablesArray.length];

	for (int i = 0; i < currentSyllablesArray.length; i++) {
		syllables[i] = Integer.parseInt(currentSyllablesArray[i]);
	}

	return syllables;

}

int getSyllableCount(String wordVal) {

	ArrayList<Integer> syllablesArrayList = new ArrayList<Integer>();

	String currentWordSyllables = RiTa.getSyllables(wordVal);

	String[] currentSyllablesArray = split(currentWordSyllables,"/");

	int syllableCount = currentSyllablesArray.length;

	return syllableCount;
	
}

boolean testStressesOfWordAgaintPattern(Word wordToTest, int startingIndex) {
	
	int[] stressPattern = {1,0,1,0};

	int[] currentWordStresses = wordToTest.stresses;

	for (int i = 0; i < currentWordStresses.length; i++) {
		if ( currentWordStresses[i] != stressPattern[startingIndex + i] ) {
			return false;
		}
	}

	return true;

}

Word findWordThatMatchesStressPattern(Word[] wordsToFilter, int startingIndex, int maxSyllableCount) {
	// Search through the Array of words (which have already been filtered for number of syllables)
	// and find a word among them that matches the stress pattern required
	int indexOfRemoved;
	boolean resultFoundRandomly = false;
	boolean resultFoundSystematically = false;
	boolean resultFoundInLexicon = false;
	int[] tmpSylArray = {1};
	Word foundWord = new Word("BOSS", 99, tmpSylArray, 1);

	// Try three times to randomly find a word that matches in the existing pool of words
	for (int i = 0; i < 3; i++) {

		int randomIndex;

		// Get a random index value based on the length of the results array
		randomIndex = int( random(wordsToFilter.length) );
		
		// Get desired starting index by taking number of syllables, subtracting how many spaces are left, then subtract one to get index

		// Run function to see if current word matches the stress arrangement we're looking for. Returns 'true' if it does.
		boolean fitsStressPattern = testStressesOfWordAgaintPattern(wordsToFilter[randomIndex],startingIndex);
		
		if (fitsStressPattern) {

			int filteredLength = wordsToFilter[randomIndex].stresses.length;

			foundWord = wordsToFilter[randomIndex];

			resultFoundRandomly = true;

			break;

		}

	}

	// If, after trying three times, we can't find a random word, systematically iterate over each word in the array until a match is found
	if (!resultFoundRandomly) {
		
		for (int m = 0; m < wordsToFilter.length; m++) {

			boolean matchesStresses = testStressesOfWordAgaintPattern(wordsToFilter[m],startingIndex);


			if (matchesStresses) {

				int filteredLength = wordsToFilter[m].stresses.length;

				foundWord = wordsToFilter[m];

				resultFoundSystematically = true;

				// After systematically finding a word and adding it to the current line, break out of the loop
				break;
			}
			
		}

	}

	// If a word is not found randomly or systematically in the pool of words, go to the lexicon to try and find a random word that matches. Try 100 times. 
	if (!resultFoundRandomly && !resultFoundSystematically) {

		for (int v = 0; v < 100; v++) {

			String randomWordString = RiTa.randomWord("vb",(int)random(maxSyllableCount));

			if (randomWordString != "") {

				int[] tmpSyl = getSyllableStresses(randomWordString);
				int tmpSylCount = getSyllableCount(randomWordString);

				Word tmpRandomWord = new Word(randomWordString,100,tmpSyl,tmpSylCount);

				if ( testStressesOfWordAgaintPattern(tmpRandomWord,startingIndex) ) {
					
					foundWord = tmpRandomWord;

					resultFoundInLexicon = true;
					
					break;

				}

			}

		}

	}

	// If random, systematic, and lexicon fail to find a match, set word to ""
	// Tried our best, that word will just have to be blank.
	if (!resultFoundRandomly && !resultFoundSystematically && !resultFoundInLexicon) {
		foundWord = new Word("",-1,tmpSylArray,0);
	}
	
	return foundWord;

}

void removeWordFromMasterList(ArrayList<Word> masterArray, Word wordToRemove) {
	
	int indexOfRemoved = getIndexOfRemoved(masterArray,wordToRemove);
	masterArray.remove(indexOfRemoved);

}

// Ideas for next steps: Rhyme scheme. Evaluate if word at the end of a line rhymes with another word (from Array for Words). If there is at least one match, randomly choose one of the rhyming words, with the correct number of syllables. If not, randomly choose a word that rhymes and correct correct number of syllables from the dictionary/lexicon.
// UI design: number of syllables per line, number of lines per stanza, rhyme scheme, perfect or imperect rhymes, meter (e.g., iambic)