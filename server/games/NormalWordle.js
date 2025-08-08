import readline from "readline";
import { readSettings, getLetterSymbols } from "../utils.js";

class NormalWordleGame {
  constructor(settings, debugMode = false) {
    // Add debugMode parameter with default false
    this.settings = {
      words: settings.words.map((word) => word.toUpperCase()),
      maxRounds: settings.maxRounds,
      caseSensitive: settings.caseSensitive || false,
    };
    this.debugMode = debugMode;
    this.resetGame();
  }

  resetGame() {
    // Select a random answer
    this.answer =
      this.settings.words[
        Math.floor(Math.random() * this.settings.words.length)
      ].toUpperCase();
    // Only log answer if debug mode is true
    if (this.debugMode) {
      console.log("[DEBUG] System Word List:", this.settings.words);
      console.log("[DEBUG] Choosen Answer:", this.answer);
    }

    this.guesses = [];
    this.currentRound = 0;
    this.isGameOver = false;
    this.isWon = false;
  }

  submitGuess(guess) {
    if (this.isGameOver) {
      throw new Error("Game is already over");
    }

    if (guess.length !== 5) {
      throw new Error("Guess must be 5 letters long");
    }

    // Normalize case
    guess = this.settings.caseSensitive ? guess : guess.toUpperCase();

    // Validate guess is in word list
    if (!this.settings.words.includes(guess)) {
      throw new Error("Not in word list");
    }

    const result = this.evaluateGuess(guess);
    this.guesses.push(result);
    this.currentRound++;

    // Check win condition
    if (guess === this.answer) {
      this.isWon = true;
      this.isGameOver = true;
      return result;
    }

    // Check lose condition
    if (this.currentRound >= this.settings.maxRounds) {
      this.isGameOver = true;
    }

    return result;
  }

  evaluateGuess(guess) {
    const answerLetters = this.answer.split("");
    const guessLetters = guess.split("");
    const result = [];
    const answerLetterCounts = {};

    // First pass: count letters in answer (excluding exact matches)
    for (let i = 0; i < 5; i++) {
      if (guessLetters[i] !== answerLetters[i]) {
        answerLetterCounts[answerLetters[i]] =
          (answerLetterCounts[answerLetters[i]] || 0) + 1;
      }
    }

    // Second pass: evaluate each letter
    for (let i = 0; i < 5; i++) {
      const letter = guessLetters[i];
      let status;

      if (letter === answerLetters[i]) {
        status = "hit";
      } else if (answerLetterCounts[letter] > 0) {
        status = "present";
        answerLetterCounts[letter]--;
      } else {
        status = "miss";
      }

      result.push({ letter, status });
    }

    return result;
  }

  getGameState() {
    return {
      answer: this.isGameOver ? this.answer : null,
      currentRound: this.currentRound,
      maxRounds: this.settings.maxRounds,
      isGameOver: this.isGameOver,
      isWon: this.isWon,
      guesses: this.guesses,
      remainingRounds: this.settings.maxRounds - this.currentRound,
    };
  }
}
function consoleTesting() {
  console.log("====== WORDLE CONSOLE TEST ======");
  let settings;
  let game;

  // Initialize settings
  try {
    settings = readSettings("./setting.json");
    console.log("Reading setting file successfully");
  } catch (error) {
    console.error("Fatal error reading settings:", error.message);
    process.exit(1);
  }

  // Initialize game
  try {
    game = new NormalWordleGame(settings, true); // true enables debug mode
    console.log("Game initialized successfully");
  } catch (error) {
    console.error("Fatal error initializing game:", error.message);
    process.exit(1);
  }

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  console.log(`Guess the 5-letter word (${game.settings.maxRounds} attempts)`);
  console.log("Legend: O = Hit, ? = Present, _ = Miss");
  console.log("Type your guess and press Enter:");

  function playTurn() {
    rl.question(`Attempt ${game.currentRound + 1}: `, (input) => {
      try {
        const guess = input.trim().toUpperCase();
        const result = game.submitGuess(guess);

        // Display results
        console.log("Your guess: ", result.map((r) => r.letter).join(" "));
        console.log(
          "Feedback:   ",
          result
            .map((r) => {
              switch (r.status) {
                case "hit":
                  return "O";
                case "present":
                  return "?";
                default:
                  return "_";
              }
            })
            .join(" ")
        );

        // Check game state
        const state = game.getGameState();
        if (state.isGameOver) {
          if (state.isWon) {
            console.log(
              `\n✅ Correct! You won in ${state.currentRound} tries!`
            );
          } else {
            console.log(`\n❌ Game over! The word was: ${state.answer}`);
          }
          rl.close();
          return;
        }

        console.log(`Remaining attempts: ${state.remainingRounds}`);
        playTurn(); // Continue to next turn
      } catch (error) {
        console.error(`⚠️ ${error.message}`);
        playTurn(); // Let them try again
      }
    });
  }

  playTurn(); // Start the first turn
}

export { NormalWordleGame, consoleTesting };
