import UIKit

class PostViewModel {
    var completeText: String = ""
    var postedImageArr = [UIImage]()
    var tagName: String = ""
    var imageURL: String = "" {
        didSet {
            requestPost2()
        }
    }
    var imageURLs = [String]()
    func printprint() {
        print(completeText)
        print(tagName)
        print(imageURL)
    }
    
     func requestOnlyImage() {
        // Prepare URL
        let url = URL(string: "https://9qedenmbo3.execute-api.ap-northeast-2.amazonaws.com/api/upload_image")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        //request header
        let boundary = "Boundary_\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //request body
        var data = Data()
        for image in postedImageArr {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"file\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        }
        
        request.httpBody = data
        
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
                        
            let decoder = JSONDecoder()
            guard let data = data else {
                print("No data")
                return
            }
                do {
                    let result = try decoder.decode(ImagePostService.self, from: data)
                    print(result.url)
                    self.imageURL = result.url
                } catch {
                    print("can't decode data")
                }
            
        }
        task.resume()
//         print(imageURL)
    }
    
    func requestPost2() {
            imageURLs.append(imageURL)
            let comment = PostService(post: completeText, author: "kim", tag: tagName, images: imageURLs)
            guard let uploadData = try? JSONEncoder().encode(comment)
            else {return}

            let url = URL(string: "https://9qedenmbo3.execute-api.ap-northeast-2.amazonaws.com/api/v1/post/write")

            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in

                if let e = error {
                    NSLog("An error has occured: \(e.localizedDescription)")
                    return
                }
                
                print("comment post success")
            }
            task.resume()
    }
}
