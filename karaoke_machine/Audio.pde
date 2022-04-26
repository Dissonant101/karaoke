class Audio {
  float[] spectrum;
  FFT fft;
  
  Audio(PApplet p) {
    this.spectrum = new float[BANDS];
    this.fft = new FFT(p, BANDS);
  }
  
  float getFrequency() {
    this.fft.analyze(this.spectrum);
    return argMax(this.spectrum) * 44100 / BANDS / 2;
  }
  
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
