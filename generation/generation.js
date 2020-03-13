const sudoku = require('./sudoku');

var startingLevel = 1;
var difficulty = "hard";
var numberOfLevels = 50;
var levels = [];

for (let i = 0; i < numberOfLevels; i++, startingLevel++) {
    var initialLevel = sudoku.generate(difficulty, true);
    var solution = sudoku.solve(initialLevel);
    var level = initialLevel.replace(/\./g, '0');
    var numberBoard = sudoku.board_string_to_grid(level).map(function (innerBoard, index) {
        return innerBoard.map(function (val, index) {
            return parseInt(val, 10);
        });
    });;

    var solutionBoard = sudoku.board_string_to_grid(solution).map(function (innerBoard, index) {
        return innerBoard.map(function (val, index) {
            return parseInt(val, 10);
        });
    });;

    var payload = {
        id: startingLevel,
        board: numberBoard,
        solution: solutionBoard
    }
    levels.push(payload);
};

var json = JSON.stringify(levels);
console.log(json);
