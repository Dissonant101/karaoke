/*
* Encapsulates the various files needed for a song in karaoke (accompaniment and melody).
*/
class Song extends Audio {
  SoundFile melody;
  SoundFile accompaniment;
  
  /*
  * Constructor for Song class.
  */
  Song(PApplet p, String melody, String accompaniment) {
    super(p);
    this.melody = new SoundFile(p, melody);
    this.accompaniment = new SoundFile(p, accompaniment);
    this.fft.input(this.melody);
  }
}
