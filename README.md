# MultiSnail.Saves
Will You Snail? mod that adds an ability to have multiple save folders, all with different save files, options and e.t.c.

## Usage
Launch the game with a "-saveloc [Instance Name]" parameter
It will make an "Instances" folder in your WYS save directory, inside of it you can find a folder named after your instance you specified.

## Installation
1. Install [GMML](https://github.com/cgytrus/gmml)
2. Install the mod

## Building
1. Create `_set_game_dir.bat` in `scripts/bat` and paste the following contents into it,
   replacing `<game dir>` with the path to the game:
```
set GAME_DIR=<game dir>
```

2. Run `libs.bat`
3. Build
