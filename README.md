# Pacman-x86-assembly

course:微算機概論實習 陸敬互教授

## Code Features
### Ghost how to chased the pacman
In our game we have four ghost, each ghost have it's unique algorithm. Below is the brief introduction.

### Ghost1 algorithm  
Ghost1 will find the shortest route to chased to Pacman.
<p align="center"><img src="1.png" width="300" height="225"></p>


### Ghost2 algorithm  
Ghost2 will chased 8 space infront of the Pacman.
<p align="center"><img src="2.png" width="300" height="225"></p>


### Ghost3 algorithm  
Ghost3 will chased the position which can let Pacman be the middle of the Ghost1 and Ghost3
<p align="center"><img src="3.png" width="300" height="225"></p>

### Ghost4 algorithm  
Ghost4 will chased the position which can let Pacman be the middle of the Ghost2 and Ghost4
<p align="center"><img src="4.png" width="300" height="225"></p>

## How to find the best direction
>[!CAUTION]
>Due to the difficulty in accomplish recursive. So we use other method to find the direction. Althought the result may not be the best solution. But this is the most easy way to find out the direction
