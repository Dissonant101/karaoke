/*
* Stores the fast fourier transform of an audio input.
*/
public abstract class Audio {
  private final Map<String, Integer> NOTE_TO_VALUE;
  protected float[] spectrum;
  protected FFT fft;
  
  /*
  * Constructor for Audio class.
  */
  public Audio(PApplet p) {
    String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    Map<String, Integer> map = new HashMap<String, Integer>();
    for (int i = 0; i < 12; i++) {
      map.put(notes[i], i);
    }
    NOTE_TO_VALUE = Collections.unmodifiableMap(map);    
    this.spectrum = new float[BANDS];
    this.fft = new FFT(p, BANDS);
  }
  
  /*
  * Abstract method for starting an audio.
  */
  public abstract void start();
  
  /*
  * Abstract method for stopping an audio.
  */
  public abstract void stop();
  
  /*
  * Returns the frequency with the highest amplitude in the FFT.
  */
  public float getFrequency() {
    this.fft.analyze(this.spectrum);
    return argMax(this.spectrum) * 44100 / BANDS / 2;
  }
  
  /*
  * Returns the frequency of the note that the actual frequency is closest to.
  */
  public String getClosestPitch(float frequency) {
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
  
  /*
  * Returns the name of the note that corresponds to the rounded frequency without the octave number.
  */
  public String getClosestNote(float frequency) {
    String closestPitch = getClosestPitch(frequency);
    
    if (closestPitch.indexOf("/") == -1) {
      return closestPitch.substring(0, 1);
    } else {
      return closestPitch.substring(0, 2);
    }
  }
  
  /*
  * Returns a value that represents the note number.
  */
  public int getClosestNoteValue(float frequency) {
    return NOTE_TO_VALUE.get(getClosestNote(frequency));
  }
  
  /*
  * Compares two audios and returns a float determining how similar they are.
  */
  public float compare(Audio other, Float runningSum, Integer n) {
    int f1 = this.getClosestNoteValue(this.getFrequency());
    int f2 = other.getClosestNoteValue(this.getFrequency());
    float d = 100 - min(abs(f1 - f2), 12 - abs(f1 - f2)) / 6.0 * 100;
    
    if (true) {
      runningSum += d;
      n++;
    }
    
    return d;
  }
}
