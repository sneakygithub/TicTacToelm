# TIC TAC TOElm
[![Build Status](https://travis-ci.org/sneakygithub/TicTacToelm.svg?branch=master)](https://travis-ci.org/sneakygithub/TicTacToelm)
---------- 
[Tic Tac Toe!](https://en.wikipedia.org/wiki/Tic-tac-toe) The game of trying to get three of your markers in a row before your opponent does!


## Getting Started:

 1. [Install npm](https://www.npmjs.com/get-npm)  via the instruction link or use homebrew with:
```
$ brew install node
```

 2. [Install Elm](https://guide.elm-lang.org/install.html) via the instruction link or use homebrew with:
```
$ brew install elm
```

 3.  Run `$ npm install` to install all the dependencies


### Running Tic Tac Toe:

 1. `$ npm run dev` to get the server started

 2. Navigate to [port 3000](http://localhost:3000/)

### Running the Tests:

  Tests are built with elm's built-in test suite. Use `$ elm-test` to run the test suite.

 A thorough minimax test has been included. To skip for performance, navigate to the file `/tests/Unbeatability/UnbeatabilityTest.elm` and add `skip <|` in front of the `test` in the file.


## Built With:
  - [Elm](https://guide.elm-lang.org) 0.18.0
  - [Webpack](https://webpack.js.org/) loader
