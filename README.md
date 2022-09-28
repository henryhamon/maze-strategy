# Maze-strategy
It is a programming-based game that played with your code!
You control a bot that must to find an exit on a labirinthy.

## How to play
You must to write a method "GetNextTurn" on dc.maze.Strategy class.
This method receives four boolean arguments (up, down, left, right). The arguments are either 1 (bot is next to a wall) or 0 (bot can move in that direction). The method must return one of the strings "up", "down", "left", right", signifying where the bot should move.

### Test your strategy
You have 2 labirinthies to pratice, one easy and another harder to solve.
The method EasyMatch will prepare a 10x10 maze and play your strategy.

```
$ docker-compose exec iris iris session iris
USER>Write ##class(dc.maze.Game).EasyMatch()
```
The method HardMatch will prepare a 45x20 maze and play your strategy.

```
$ docker-compose exec iris iris session iris
USER>Write ##class(dc.maze.Game).HardMatch()
```

All matches are record on dc.maze.core.Match persistent class, you can see all the steps of your solution and the general score of the match.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/intersystems-community/maze-strategy
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

## How to Test it

Open IRIS terminal:

```
$ docker-compose exec iris iris session iris
USER>write ##class(dc.PackageSample.ObjectScript).Test()
```
## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.
![docker_compose](https://user-images.githubusercontent.com/2781759/76656929-0f2e5700-6547-11ea-9cc9-486a5641c51d.gif)

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/Package/Classname.cls
[Read more about folder setup for InterSystems ObjectScript](https://community.intersystems.com/post/simplified-objectscript-source-folder-structure-package-manager)

The script in Installer.cls will import everything you place under /src into IRIS.


## What's inside the repository

### Dockerfile

The simplest dockerfile which starts IRIS and imports code from /src folder into it.
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.


### .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

### .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript

[Read about all the files in this artilce](https://community.intersystems.com/post/dockerfile-and-friends-or-how-run-and-collaborate-objectscript-projects-intersystems-iris)
