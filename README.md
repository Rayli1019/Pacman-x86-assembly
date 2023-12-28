# Pacman-x86-assembly

course:微算機概論實習 陸敬互教授

## Game rule

## Code feature
#### Ghost how to chased the pacman
In our game we have four ghost, each ghost have it's unique algorithm. Below is the brief introduction.

#### Ghost1 algorithm  
Ghost1 will find the shortest route to chased to Pacman.
<p align="center"><img src="1.png" width="300" height="225"></p>


#### Ghost2 algorithm  
Ghost2 will chased 8 space infront of the Pacman.
<p align="center"><img src="2.png" width="300" height="225"></p>


#### Ghost3 algorithm  
Ghost3 will chased the position which can let Pacman be the middle of the Ghost1 and Ghost3
<p align="center"><img src="3.png" width="300" height="225"></p>

#### Ghost4 algorithm  
Ghost4 will chased the position which can let Pacman be the middle of the Ghost2 and Ghost4
<p align="center"><img src="4.png" width="300" height="225"></p>

## How to find the best direction
>[!NOTE]
>Due to assembly is difficult to accomplish recursive. So we use other method to find the direction. Althought the result may not be the best solution. But this is the most easy way to find out the direction.
### Basic principle
<p align="center"><img src="5.png" width="300" height="225"></p>

1. First will compare wheather the Ghost is on the intersection.
2. Compare which direction it doesn't have wall infront. And it can't walk backward.
3. Compute which direction it can get the shortest distance.
>[!NOTE]
>You can find out all intersection on the map and label as a different number in previous. This can reduce CPU usage.

### Other algorithm make Ghost more smarter
Because breifly using Ghost2, Ghost3, Ghost4 mode we find out the Ghost may pass the Pacman in a near distance. It's really stupid. So ghost and Pacman smaller than a certain value the Ghost will use Ghost1 mode to chase the Pacman.

But just pursuit can lead to a situation where all ghosts are very close behind the Pacman, making it impossible to catch the Pacman. Moreover, because they are so close to the Pacman, the calculated direction remains the same. This allows for continuous circling to score points easily. 

Therefore, we added a condition: if the pursuit algorithm is executed more than a certain number of times, the ghost will reverse direction to prevent a situation where the ghosts and the Pacman form a straight line. Additionally, as time progresses, the ghosts will move faster.

### File Read
We can find out whether there is any file exist. If there isn't any file exist. We will create one and show the basic rule of the game.

### Play Music
Because if only simple images are displayed, it might feel a bit dull, so we added a sound component. When the sprite is caught by a ghost, it will emit a sound to alert the player that they have died. Similarly, at the end of the game, there will be a reminder that the game has concluded. Due to constraints in the program segment, it wasn't possible to compose a full song, so it will only play a simple tune like Mi-Re-Do.

### Timing Execution
Because both the elves and ghosts require a stable clock during movement, simply using delays can result in unstable intervals between movements. A stable clock is needed. Initially, we used a timer interrupt, but the timing duration was too short for our use. Therefore, we eventually utilized the system time reading from int 21h for timing purposes.

