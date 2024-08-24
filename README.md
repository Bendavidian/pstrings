# pstrings
This repository contains the solutions for the pstrings project. The project is divided into two parts: a number guessing game and a string manipulation library.

## Overview
This project was developed with assembly language by completing two tasks: creating a basic number guessing game and implementing an advanced string manipulation library.
## Repository Contents
The repository includes the following files:
#### Part I: Number Guessing Game
* 'main.s': Assembly code for a simple number guessing game.
#### Part II: String Manipulation Library
* 'pstrings.s': Implementation of string manipulation functions.
* 'func_select.s': Function to select and execute the appropriate string manipulation function based on user input.

## Part I: Number Guessing Game
In this part, a simple number guessing game is implemented in assembly language. The game generates a random number between 0 and 10 and prompts the user to guess the number. The user has up to 5 attempts to guess correctly. Depending on the user's input, the game will either congratulate them for winning or inform them that they have lost after exhausting all attempts.
#### Features
* Random Number Generation: The game initializes with a seed provided by the user to generate a random number.
* User Interaction: The game repeatedly prompts the user to enter their guess.
* Endgame Messages: The game ends with a victory message if the user guesses correctly or a loss message if all attempts are used.
## Part II: String Manipulation Library
The second part of the project involves creating a string manipulation library in assembly. The implementation includes functions for calculating string length, swapping case of characters, and copying substrings between Pstrings.
#### Functions
* 'pstrlen': Returns the length of a given Pstring.
* 'swapCase': Converts uppercase letters to lowercase and vice versa in a given Pstring.
* 'pstrijcpy': Copies a substring from one Pstring to another based on specified start and end indices.
#### Functionality
* Interactive Menu: The program presents a menu allowing users to choose which string manipulation function to execute.
* Input Validation: Functions include checks to ensure that inputs are valid before performing operations.
 ## Example Outputs
 ![Screenshot 2024-08-24 201147](https://github.com/user-attachments/assets/d9744d1f-f98b-4307-b288-a4e3be4cd14f)

## How To Run
```bash
# Clone this repository.
git clone https://github.com/Bendavidian/pstrings.git
\```
```bash
# Go into the repository.
cd YourRepo
\```
```bash
# Compile using makefile.
make
\```
```bash
# Run the program on Linux:
./a.out
\```
```bash
# Run the program on Windows:
a.out
\```








