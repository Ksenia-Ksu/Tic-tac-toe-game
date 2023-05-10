
import UIKit


struct ScreenSize {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

struct WelcomeScreenTextFor {
    static let stepperMinValue: Double = 3
    static let stepperMaxValue: Double = 5
    static let firstRowPicturesLabel = "🅾️❎❎"
    static let secondRowPicturesLabel = "❎🅾️❎"
    static let thirdRowPicturesLabel = "❎❎🅾️"
    static let welcomeLabel = "Welcome to Tic Tac Toe game!"
    static let fieldsChoiseLabel = "Сhoose the size of the field"
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

struct Layout {
    enum WelcomeScreen {
        static let startButtonWidth: CGFloat  = 120
        static let startButtonHeigh: CGFloat  = 80
        static let offset: CGFloat = 30
    }
    enum GameScreen {
        static let offset: CGFloat = 20
    }
}
