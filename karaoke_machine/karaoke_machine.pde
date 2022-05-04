import processing.core.PApplet;
import processing.sound.*;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;
import g4p_controls.*;


static final int BANDS = 2048;
PImage b;
PImage img;
<<<<<<< Updated upstream
String[] pics = {"MR_S_ARMUP.png","MR_S_ARMMID.png","MR_S_ARMDOWN.png","MR_S_ARMMID.png"};
=======
PImage img2;
String[] pics = {"MR_S_ARMUP.png", "MR_S_ARMMID.png", "MR_S_ARMDOWN.png", "MR_S_ARMMID.png"};
>>>>>>> Stashed changes
int currentPic = 0;
int bpm = 85;

boolean bg = true;

Map<Float, String> frequencyTable;
Microphone mic;
Song song;

String micNote, songNote;
float micFrequency, songFrequency;
int accuracy;
PImage[] backgrounds;

void setup() {
  size(466, 466); // 512x360, 1021x763
  textSize(24);
  textAlign(LEFT);
  fill(0);
  frameRate(30);
  
  b = loadImage("Curtains img 1.jpg");
  
  createGUI();
  
  img = loadImage(pics[currentPic]);
<<<<<<< Updated upstream
  
  frequencyTable = generateFrequencyTable();
  
  backgrounds = new PImage[4];
  backgrounds[0] = loadImage("MR_S_ARMUP.png");
  backgrounds[1] = loadImage("MR_S_ARMMID.png");
  backgrounds[2] = loadImage("MR_S_ARMDOWN.png");
  backgrounds[3] = loadImage("MR_S_ARMMID.png");
=======
  img2 = loadImage("Game over.png");
  frequencyTable = generateFrequencyTable();
  createGUI();
  pause.setVisible(false);
  volume.setVisible(false);
  quit.setVisible(false);
  backToMenu.setVisible(false);
  volumeLabel.setVisible(false);
>>>>>>> Stashed changes
}
void draw() {
  
  if(bg) 
    background(b);
<<<<<<< Updated upstream
  
  else {
    background(255);
    //changeBackground();
=======
    fill(255);
    textSize(40);
    text("Karaoke Hero", 253, 170);
  } else if (gameState == "play") {
    changeBackground();

>>>>>>> Stashed changes
    for (int i = 0; i < BANDS; i++) {
 
    }
    
    if (frameCount % 5 == 0) {
      micFrequency = mic.getFrequency();
      songFrequency = song.getFrequency();
      micNote = mic.getClosestNote(micFrequency);
      songNote = song.getClosestNote(songFrequency);
      accuracy = round(song.compare(mic));
    }
<<<<<<< Updated upstream
    
    text("Microphone: " + micNote + " " + micFrequency, width / 4, height / 2 - 100);
    text("Song: " + songNote + " " + songFrequency, width / 4, height / 2 - 50);
    text("Accuracy: " + accuracy + " %", width / 4, height / 2);
=======
  
    showNotes();
    drawLyrics(song);
  } else if (gameState == "game over") {
      image(img2, 0, 0);
      fill(255);
      textSize(15);
      float accuracy = getAverageAccuracy();
      println(accuracy);
      text("Congrats! Your accuracy was:" + accuracy, 253, 320);
>>>>>>> Stashed changes
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
  } catch (IOException e) {}
  
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

   if(frameCount % changesPerMin == 0) {
     currentPic ++;
     img = loadImage(pics[currentPic%4]); 
   }
}
