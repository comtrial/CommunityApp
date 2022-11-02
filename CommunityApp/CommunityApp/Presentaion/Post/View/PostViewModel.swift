import UIKit

struct PostViewModel {
    var completeText: String = ""
    var postedImageArr = [UIImage]()
    var tagName: String = ""
    
    func printprint() {
        print(completeText)
        print(tagName)
    }
}
