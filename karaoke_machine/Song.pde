/*
* Encapsulates the various files needed for a song in karaoke (accompaniment, melody, lyrics).
*/
public class Song extends Audio {
  /* Contains the audio stream from a melody file. */
  public SoundFile melody;
  /* Contains the audio stream from an accompaniment file. */
  public SoundFile accompaniment;
  /* Contains the lyrics of a song. */
  public String[] lyrics;
  /* Contains the bpm of a song. */
  public float bpm;
  
  /*
  * Constructor for Song class.
  */
  public Song(PApplet p, String melody, String accompaniment, String lyrics, float bpm) {
    super(p);
    this.melody = new SoundFile(p, melody);
    this.accompaniment = new SoundFile(p, accompaniment);
    this.lyrics = loadStrings(lyrics);
    this.bpm = bpm;
    this.fft.input(this.melody);
  }
  
  /*
  * Starts playing the melody and accompaniment files.
  */
  @Override
  public void start() {
    this.melody.play(1, vol);
    this.accompaniment.play(1, vol);
  }
  
  /*
  * Stops playing the melody and accompaniment files.
  */
  @Override
  public void stop() {
    this.melody.stop();
    this.accompaniment.stop();
  }
  
  /*
  * Stops playing the melody and accompaniment files but keeps its position in the song.
  */
  public void pause() {
    this.melody.pause();
    this.accompaniment.pause();
  }
  
  /*
  * Checks if the song is currently playing.
  */
  public boolean isPlaying() {
    return this.accompaniment.isPlaying();
  }
  
  /*
  * Sets the volume of the song.
  */
  public void setVolume() {
    this.melody.amp(vol);
    this.accompaniment.amp(vol);
  }
}
