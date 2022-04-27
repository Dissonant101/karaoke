/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void leaderboardButtonClicked(GButton source, GEvent event) { //_CODE_:button1:427554:
  
} //_CODE_:button1:427554:

public void startButtonClicked(GButton source, GEvent event) { //_CODE_:button2:721551:
  
} //_CODE_:button2:721551:

public void difficultySliderChanged(GCustomSlider source, GEvent event) { //_CODE_:Difficulty:921362:

} //_CODE_:Difficulty:921362:

public void songSelectionListClicked(GDropList source, GEvent event) { //_CODE_:Song_Selection:965194:

} //_CODE_:Song_Selection:965194:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  button1 = new GButton(this, 236, 185, 108, 30);
  button1.setText("Leaderboard");
  button1.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  button1.addEventHandler(this, "leaderboardButtonClicked");
  button2 = new GButton(this, 122, 184, 80, 30);
  button2.setText("Start");
  button2.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  button2.addEventHandler(this, "startButtonClicked");
  Difficulty = new GCustomSlider(this, 182, 246, 100, 40, "grey_blue");
  Difficulty.setShowValue(true);
  Difficulty.setShowLimits(true);
  Difficulty.setLimits(0.0, 0.0, 1.0);
  Difficulty.setNbrTicks(5);
  Difficulty.setStickToTicks(true);
  Difficulty.setShowTicks(true);
  Difficulty.setNumberFormat(G4P.DECIMAL, 2);
  Difficulty.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  Difficulty.setOpaque(false);
  Difficulty.addEventHandler(this, "difficultySliderChanged");
  Song_Selection = new GDropList(this, 124, 313, 221, 100, 4, 10);
  Song_Selection.setItems(loadStrings("list_965194"), 0);
  Song_Selection.addEventHandler(this, "songSelectionListClicked");
}

// Variable declarations 
// autogenerated do not edit
GButton button1; 
GButton button2; 
GCustomSlider Difficulty; 
GDropList Song_Selection; 