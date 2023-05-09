
import UIKit


struct ScreenSize {
    
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

struct WelcomeScreenTextFor {
    
    static let stepperMinValue: Double = 3
    static let stepperMaxValue: Double = 5
    
    static let picturesLabel = "❎❎❎"
    static let welcomeLabel = "Welcome to Tic Tac Toe game!"
    static let fieldsChoiseLabel = "Сhoose the size of the field from 3 to 5"
    static let fieldsCounterLabel = "3"
    static let startButton = "Start"
    
}


struct GameScreenTextFor {
    enum Alert {
        static let restart = "Restart"
        static let nextRound = "Next Round"
        static let winner = "🥳 The winner is: "
        static let noWinner = "There is no winner... Try again?"
    }
}
