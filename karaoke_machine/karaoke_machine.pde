import g4p_controls.*;
import processing.core.PApplet;
import processing.sound.*;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;

static final int BANDS = 2048;

PImage img;
String[] pics = {"MR_S_ARMUP.png", "MR_S_ARMMID.png", "MR_S_ARMDOWN.png", "MR_S_ARMMID.png"};
int currentPic = 0;
int bpm = 85;
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
String note;
String previousNote;
ArrayList<PVector> movingNotes = new ArrayList<PVector>();
ArrayList<String> noteName = new ArrayList<String>();

boolean paused = false;

Map<Float, String> frequencyTable;
Microphone mic;
Song song;
String micNote, songNote;
float micFrequency, songFrequency;
int accuracy;
PImage[] backgrounds;

void setup() {
  size(512, 360); // 512x360, 1021x763
  textSize(24);
  textAlign(LEFT);
  fill(0);
  frameRate(30);

  img = loadImage(pics[currentPic]);

  frequencyTable = generateFrequencyTable();
  mic = new Microphone(this);
  song = new Song(this, "baby_cat.mp3", "baby_cat.mp3");
  backgrounds = new PImage[4];
  backgrounds[0] = loadImage("MR_S_ARMUP.png");
  backgrounds[1] = loadImage("MR_S_ARMMID.png");
  backgrounds[2] = loadImage("MR_S_ARMDOWN.png");
  backgrounds[3] = loadImage("MR_S_ARMMID.png");
  mic.start();
  song.start();
}

void draw() {

  background(255);
  //changeBackground();

  for (int i = 0; i < BANDS; i++) {
    line(i, height, i, height - mic.spectrum[i] * height * 5);
  }

  if (frameCount % 10 == 0) {
    micFrequency = mic.getFrequency();
    songFrequency = song.getFrequency();
    micNote = mic.getClosestNote(micFrequency);
    songNote = song.getClosestNote(songFrequency);
    accuracy = round(song.compare(mic));
    findNote();
  }

  showNotes();
  text("Microphone: " + micNote + " " + micFrequency, width / 4, height / 2 - 100);
  text("Song: " + songNote + " " + songFrequency, width / 4, height / 2 - 50);
  text("Accuracy: " + accuracy + " %", width / 4, height / 2);
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
int argMax(float[] vals) {
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
* Detremines when to change the background image
 */
void changeBackground() {
  background(img);
  int changesPerMin = round(frameRate*60/bpm);

  if (frameCount % changesPerMin == 0) {
    currentPic ++;
    img = loadImage(pics[currentPic%4]);
  }
}

/*
* shows notes on screen
 */
void showNotes() {
  fill(0, 0, 255);
  int[] noteHeight = {height/14, height/7, 3*height/14, 4*height/14, 5*height/14, 6*height/14, height/2, 8*height/14, 9*height/14, 10*height/14, 11*height/14, 6*height/7};

  for (int i = 0; i < notes.length; i++) {
    if (note == notes[i]) {
      if (note != previousNote) {
        movingNotes.add(new PVector(width, noteHeight[i]));
        noteName.add(note);
        previousNote = note;
      }
    }
  }

  for (int j = 0; j < movingNotes.size(); j++) {
    text(noteName.get(j), movingNotes.get(j).x, movingNotes.get(j).y);
    movingNotes.get(j).x -= 2;

    if (movingNotes.get(j).x < 0) {
      movingNotes.remove(j);
      noteName.remove(j);
    }
  }
  fill(0);
}

void findNote() {
  for (int i = 0; i < 12; i++) {
    if (songNote.equals(notes[i]))
      note = notes[i];
  }
}
