import processing.core.PApplet;
import processing.sound.*;
import java.util.Map;
import java.util.HashMap;

static final int BANDS = 2048;

PImage img;
String[] pics = {"MR_S_ARMUP.png","MR_S_ARMMID.png","MR_S_ARMDOWN.png","MR_S_ARMMID.png"};
int currentPic = 0;
int bpm = 85;

Map<Float, String> frequencyTable;
Microphone mic;
Song song;

void setup() {
  size(512, 360);
  frameRate(10);
  
  img = loadImage(pics[currentPic]);
  
  frequencyTable = generateFrequencyTable();
  mic = new Microphone(this);
  song = new Song(this, "baby_cat.mp3", "baby_cat.mp3");
  mic.in.start();
  song.melody.play(1, 1);
}

void draw() {
  changeBackground();
  
  for (int i = 0; i < width; i++) {
    line(i, height, i, height - mic.spectrum[i] * height * 10);
  }
  
  //println(mic.getFrequency() + " " + mic.findClosestNote());
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
