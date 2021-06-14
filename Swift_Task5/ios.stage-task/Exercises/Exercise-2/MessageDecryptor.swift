import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var encodingMessage = message
        if encodingMessage.first == "[" {
            encodingMessage.removeFirst()
            encodingMessage.removeLast()
        }
        var stack = [(String, Int)]()
        var formattedMessage = ""
        var number = 0
        
        for content in encodingMessage {
            switch content {
                case "[":
                    stack.append((formattedMessage, number))
                    number = 0
                    formattedMessage = ""
                case "]":
                    let (prev, number) = stack.removeLast()
                    formattedMessage = prev + String(repeating: formattedMessage, count: number)
                case _ where content.isNumber:
                    number *= 10
                    number += Int(String(content))!
                default:
                    formattedMessage += String(content)
            }
        }
    return formattedMessage
   }
}
