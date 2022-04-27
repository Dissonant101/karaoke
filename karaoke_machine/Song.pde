/*
* Encapsulates the various files needed for a song in karaoke (accompaniment and melody).
*/
public class Song extends Audio {
  private SoundFile melody;
  private SoundFile accompaniment;
  
  /*
  * Constructor for Song class.
  */
  public Song(PApplet p, String melody, String accompaniment) {
    super(p);
    this.melody = new SoundFile(p, melody);
    this.accompaniment = new SoundFile(p, accompaniment);
    this.fft.input(this.melody);
  }
  
  /*
  * Start playing the melody and accompaniment files.
  */
  @Override
  public void start() {
    this.melody.play(1, 1);
    this.accompaniment.play(1, 1);
  }
  
  /*
  * Stop playing the melody and accompaniment files.
  */
  @Override
  public void stop() {
    this.melody.stop();
    this.accompaniment.stop();
  }
  
  public boolean isPlaying() {
    return melody.isPlaying();
  }
}
