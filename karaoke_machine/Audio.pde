/*
* Stores the fast fourier transform of an audio input.
*/
class Audio {
  float[] spectrum;
  FFT fft;
  
  /*
  * Constructor for Audio class.
  */
  Audio(PApplet p) {
    this.spectrum = new float[BANDS];
    this.fft = new FFT(p, BANDS);
  }
  
  /*
  * Returns the frequency with the highest amplitude in the FFT.
  */
  float getFrequency() {
    this.fft.analyze(this.spectrum);
    return argMax(this.spectrum) * 44100 / BANDS / 2;
  }
  
  /*
  * Returns the note that is closest to the highest frequency in the FFT.
  */
  String findClosestNote() {
    float distance;
    float closestFrequency = 0;
    float minDistance = Float.POSITIVE_INFINITY;
    
    for (float key : frequencyTable.keySet()) {
      if ((distance = abs(this.getFrequency() - key)) < minDistance) {
        minDistance = distance;
        closestFrequency = key;
      }
    }
    
    return frequencyTable.get(closestFrequency);
  }
}
