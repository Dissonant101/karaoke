import g4p_controls.*;
import processing.core.PApplet;
import processing.sound.*;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;
import g4p_controls.*;

static final int BANDS = 2048;
PApplet p = this;
String gameState = "menu";
float vol = 1.0;
PImage b;
PImage img;
PImage img2;
String[] pics = {"MR_S_ARMUP.png", "MR_S_ARMMID.png", "MR_S_ARMDOWN.png", "MR_S_ARMMID.png"};
int currentPic = 0;
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
String note;
String previousNote;
ArrayList<PVector> movingNotes = new ArrayList<PVector>();
ArrayList<String> noteName = new ArrayList<String>();

boolean paused = false;
String choice;
int space = 340;

Map<Float, String> frequencyTable;
Microphone mic;
Song song;
Song littleLamb;
Song belongWithMe;
Song foreverLikeThat;
String micNote, songNote;
float micFrequency, songFrequency;
float accuracySum;
int divisor;

void setup() {
  size(512, 450);
  frameRate(30);
  textAlign(CENTER);
  PFont candara;
  candara = createFont("Candara", 40);
  textFont(candara);
  b = loadImage("Curtains img 1.jpg");
  img = loadImage(pics[currentPic]);
  img2 = loadImage("Game over.png");
  frequencyTable = generateFrequencyTable();
  loadSongs();
  createGUI();
  pause.setVisible(false);
  volume.setVisible(false);
  quit.setVisible(false);
  backToMenu.setVisible(false);
  volumeLabel.setVisible(false);
}

void draw() {
  if (gameState == "menu") {
    fill(255);
    textSize(40);
    background(b);
    text("Karaoke Hero", 253, 170);
  } else if (gameState == "play") {
    if (!paused) {
      changeBackground();
      showNotes();
    }
  
    micFrequency = mic.getFrequency();
    songFrequency = song.getFrequency();
    micNote = mic.getClosestNote(micFrequency);
    songNote = song.getClosestNote(songFrequency);
    song.compare(mic);
    findNote();
    drawLyrics(song);
  } else if (gameState == "game over") {
      image(img2, 0, 0);
      fill(255);
      textSize(15);
      text("Congrats! Your accuracy was: " + round(getAverageAccuracy()) + "%", 253, 320);
  }
}

/*
* Returns a hashmap of frequencies to the corresponding pitches.
 */
Map<Float, String> generateFrequencyTable() {
  Map<Float, String> table = new HashMap<Float, String>();
  BufferedReader reader = createReader("freq_to_note.txt");
  String line;

  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ",");
      String note = pieces[0];
      float freq = float(pieces[1]);
      table.put(freq, note);
    }
  }
  catch (IOException e) {
  }

  return table;
}

/*
* Returns the index of the max value in an array of floats.
*/
public int argMax(float[] vals) {
  int maxIndex = 0;
  float max = 0;

  for (int i = 0; i < vals.length; i++) {
    if (vals[i] > max) {
      maxIndex = i;
      max = vals[i];
    }
  }

  return maxIndex;
}

/*
* Determines when to change the background image.
*/
void changeBackground() {
  image(img, 0, 0);
  int changesPerMin = round(frameRate*60/song.bpm);

  if (frameCount % changesPerMin == 0) {
    currentPic ++;
    img = loadImage(pics[currentPic%4]);
  }
}

/*
* Returns the average accuracy as a float.
*/
float getAverageAccuracy() {
  return accuracySum / divisor;
}

/*
* Creates soundfiles for all songs.
*/
void loadSongs() {
  littleLamb = new Song(this, "Little Lamb Melody.wav", "Little Lamb Accompaniment.wav", "Little Lamb Lyrics.txt", 85);
  littleLamb.stop();
  belongWithMe = new Song(this, "Little Lamb Melody.wav", "Little Lamb Accompaniment.wav", "Little Lamb Lyrics.txt", 85);
  belongWithMe.stop();
  foreverLikeThat = new Song(this, "Little Lamb Melody.wav", "Little Lamb Accompaniment.wav", "Little Lamb Lyrics.txt", 85);
  foreverLikeThat.stop();
}
