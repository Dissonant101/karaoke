class Song extends Audio {
  SoundFile melody;
  SoundFile accompaniment;
  
  Song(PApplet p, String melody, String accompaniment) {
    super(p);
    this.melody = new SoundFile(p, melody);
    this.accompaniment = new SoundFile(p, accompaniment);
    this.fft.input(this.melody);
  }
}
