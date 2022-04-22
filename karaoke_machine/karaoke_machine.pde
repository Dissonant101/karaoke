import processing.sound.*;
import java.util.Map;
import java.util.HashMap;

Map<Float, String> frequencyTable;
int bands;
float[] spectrum;
FFT fft;
AudioIn in;

void setup() {
  size(512, 360);
  background(255);
  frameRate(30);
  
  frequencyTable = new HashMap<Float, String>();
  generateFrequencyTable();
  
  bands = 2048;
  spectrum = new float[bands];
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  in.start();
  fft.input(in);
}      

void draw() {
  background(255);
  fft.analyze(spectrum);
  float frequency = indexOfMax(spectrum) * 44100 / bands / 2;
  print(frequency + " ");
  println(findClosestNote(frequency));

  for (int i = 0; i < bands; i++) {
    line(i, height, i, height - spectrum[i] * height * 10);
  }
}

void generateFrequencyTable() {
  BufferedReader reader = createReader("freq_to_note.txt");
  String line;

  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ",");
      String note = pieces[0];
      float freq = float(pieces[1]);
      frequencyTable.put(freq, note);
    }
  } 
  catch (IOException e) {
  }
}

int indexOfMax(float[] vals) {
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

String findClosestNote(float frequency) {
  float distance;
  float closestFrequency = 0;
  float minDistance = Float.POSITIVE_INFINITY;

  for (float key : frequencyTable.keySet()) {
    if ((distance = abs(frequency - key)) < minDistance) {
      minDistance = distance;
      closestFrequency = key;
    }
  }

  return frequencyTable.get(closestFrequency);
}
