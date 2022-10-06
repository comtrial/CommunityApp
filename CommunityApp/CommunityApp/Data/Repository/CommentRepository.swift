import Foundation

class CommentRepository {

    func fetchCommentPublisher() {
        for commentPageNumber in 1...4 {
            let urlString = "https://38c0eb6a-ec24-4aa3-8eaf-db9ab721a74a.mock.pstmn.io/api/v1/comment/\(commentPageNumber)"// \(commentPAgeNumber) 보간법으로 api데이터 따로따로 받아올 수 있게
            let url = URL(string : urlString)

            guard url != nil else {
                print("Couldn't create url object")
                return
            }

            let session = URLSession.shared

            let datatask = session.dataTask(with: url!) { (data, response, error) in
                if error == nil && data != nil {
                    let decoder = JSONDecoder()


                    do {
                        let commentService = try decoder.decode(CommentService.self, from: data!)
                        print(commentService)
                    }
                    catch {
                        print("Error parsing the Json")
                    }
                }
            }
            datatask.resume()
        }
    }
}
