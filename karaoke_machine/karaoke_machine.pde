import processing.core.PApplet;
import processing.sound.*;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;

static final int BANDS = 2048;

Map<Float, String> frequencyTable;
Microphone mic;
Song song;

void setup() {
  size(512, 360);
  frameRate(10);
  
  frequencyTable = generateFrequencyTable();
  mic = new Microphone(this);
  song = new Song(this, "Little Lamb Melody.wav", "Little Lamb Accompaniment.wav");
  mic.start();
  song.start();
}

void draw() {
  background(255);
  
  for (int i = 0; i < width; i++) {
    line(i, height, i, height - mic.spectrum[i] * height * 10);
  }
  
  println(mic.getFrequency() + " " + song.getFrequency());
  println("Match: " + song.compare(mic) + "%");
  println(song.isPlaying());
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
