# Music Player App 🎵  

The Music Player App is a beautifully designed iOS application that allows users to explore, play, and manage their favorite songs. This app focuses on seamless UI transitions and smooth music playback.  

---

## Features  

### Music Playback  
- Play, Pause, and Stop songs.  
- Shuffle through the playlist.  
- Progress tracking using a progress bar.  

### User Interface  
- Elegant and user-friendly UI with customized buttons, views, and banners.  
- Support for UICollectionView and UITableView to display recommended playlists and trending songs.  
- Interactive gestures for a seamless browsing experience.  

### Functionalities  
- Dynamic Segues for smooth navigation between screens.  
- Favorite Toggle to mark/unmark favorite songs.  
- Real-time Progress Updates using `Timer`.  
- Audio Session Management with `AVAudioSession`.  

---

## Installation  

1. Clone the repository:  
    ```bash  
    git clone https://github.com/MrMarick/MusicPlayer.git  
    ```  
2. Open the project in Xcode.  
3. Run the app on the simulator or a connected device.  

---

## How It Works 

### Architecture  
This app follows the MVC Architecture (Model-View-Controller).  

### Code Breakdown  
#### 1. ViewController  
- Displays recommended songs and playlists.  
- Handles swipe gestures for carousel-like navigation in the recommended section.  
- Manages the backGroundSongView for playback controls.  

#### 2. SongListVC  
- Displays the list of songs in a playlist.  
- Allows navigation to the music player screen when a song is selected.  
- Implements play/pause and stop controls for background music playback.  

#### 3. MusicVC  
- The main music player screen with playback controls and progress tracking.  
- Uses the `MusicPlayer` singleton for music management.  
- Includes methods to:
  - Load music from a URL.  
  - Start and stop playback timers.  
  - Update UI elements dynamically based on the music's state.  

---

## Dependencies 

This app does not require external dependencies at the moment. However, it makes heavy use of native iOS frameworks:  

- AVFoundation: For music playback.  
- UIKit: For designing the UI components.  

---
