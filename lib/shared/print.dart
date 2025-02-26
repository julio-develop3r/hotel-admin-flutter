// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m

// Also support emojis

// How to open emoji panel?
// mac os: control + command + space

// windows: win + .

// linux: control + . or control + ;

void printError(String text) {
  print('\x1B[31m[error] \x1B[0m$text');
}

void printSuccess(String text) {
  print('\x1B[32m[success] \x1B[0m$text');
}

void printWarning(String text) {
  print('\x1B[33m[warning] \x1B[0m$text');
}

void printAction(String text) {
  print('\x1B[34m[action] \x1B[0m$text');
}

void printImportant(String text) {
  print('\x1B[35m[important] \x1B[0m$text');
}

void printNote(String text) {
  print('\x1B[36m[note] \x1B[0m$text');
}
