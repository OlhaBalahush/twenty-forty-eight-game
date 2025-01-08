# twenty_forty_eight

## The popular game "2048"

The 2048 game, a classic and addictive puzzle-solving experience! In this project, It was implemented a 4x4 grid where players can combine tiles strategically to achieve the elusive 2048 tile. Here's what you need to know:

**Gameplay:**
1. **Initialization:**
    - The game kicks off with a 4x4 grid populated by 3-4 tiles randomly filled with values of either 2 or 4.

2. **Swipe and Merge:**
    - Players can swipe tiles in any of the four directions, causing them to move as far as possible in the chosen direction.
    - Engaging animations have been incorporated to ensure a smooth and visually pleasing gaming experience.

3. **Tile Collisions:**
    - When two tiles with the same value collide due to a swipe, they merge into a single tile with a value twice that of the original. The score is updated accordingly.

4. **New Tile Generation:**
    - After each move, a new tile magically appears in an empty slot on the board.

5. **Game Over Conditions:**
    - The game continues until no legal moves are possible. This happens when the grid is full, and no adjacent tiles share the same value.

**User Interaction:**
- A handy restart button allows players to reset the game at any time, challenging them to beat their previous scores.

**Scoring:**
- The current and best scores are dynamically displayed during gameplay, providing players with real-time feedback on their progress.
- The best score is updated as needed when the game concludes.

**Development Approach:**
- The project adheres to best practices for coding and game development, ensuring a clean and maintainable codebase.
- Thorough documentation is provided, detailing the code structure and any significant decisions made during the development process.

## Running the Project in Visual Studio Code

### Prerequisites:
1. **Install Flutter and Dart SDK:**
    - Ensure Flutter and Dart SDKs are installed on your machine. Follow the official Flutter installation guide: [Flutter Installation](https://flutter.dev/docs/get-started/install)

### Setting up the Flutter Project:

1. **Clone the Project:**
    - Clone the project:
      ```bash
      git clone https://01.kood.tech/git/Olya/twenty-forty-eight.git
      ```

2. **Install Dependencies:**
    - Run the following command to install project dependencies:

      ```bash
      flutter pub get
      ```

### Running the Project:

1. **Select a Device:**
    - Connect a physical device or launch an emulator/simulator. You can do this using the Flutter CLI or through the VSCode interface.

      ```bash
      flutter devices
      ```

    - Select a device by clicking on the device name in the bottom-right corner of the VSCode window.

2. **Run the Application:**
    - Open the main Dart file (usually `main.dart`) and click on the green play button in the top-right corner of VSCode. Alternatively, use the following command in the terminal:

      ```bash
      flutter run
      ```

    - This will compile and run the application on the selected device.
