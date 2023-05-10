import Foundation

enum DataFlowWelcome {
    struct Request {
        let numberOfFields: Double
    }
    
    struct Response {
      let numberFields: Double
    }
    
    struct ViewModel {
        let title: String
    }
}
