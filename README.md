# Maze-Solver-Robot
## Abstact
MikroC Project for a two front wheeled Robot designed to solve 5x5 matrices using wall following algorithm. 

### Introduction and background
The idea was taken form micromouse competition (started in late 70s where small robot mice solve a 16x16 maze, the competition will be based on how much time  it will take to solve the maze, the competition is popular in many countries such as UK, Japan and Korea).
Importance of our project:
Maze solving is considered to be important field in robotics and it's also involve automation and artificial intelligence, Because we wanted to challenge our self to do something new and different, in order to develop our research skills we found our project interesting to put effort on. 

### How it works?
In our project we designed our robot to take the right wall in its movement and in order to do so, the robot must consider the following priorities:
 Turn Right if possible, If not try to walk Forward, if not try to Turn Left, if not 
 Rotate +180 degrees or -180 degrees (according for the left and right distance).
What is special about our project? In micromouse competition the starting and the ending point are fixed while in our project any square can be a starting point.
Components used:
 PIC16F877A, H-bridge, 2xDC motors, Car chassis, 3xUltrasonic 3xInfrared sensor (Line follower), External Regulator 7805 and a Breadboard.
