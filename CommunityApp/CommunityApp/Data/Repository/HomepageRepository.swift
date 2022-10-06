import Foundation
import Combine

class FeedsRepository {

    func fetchFeedsPublisher () {
       let urlString = "https://38c0eb6a-ec24-4aa3-8eaf-db9ab721a74a.mock.pstmn.io/api/v1/home"

        let url = URL(string: urlString)

        guard url != nil else {
            print("Couldn't create url object")
            return
        }

        let session = URLSession.shared

        let datatask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {

                let decoder = JSONDecoder()

                do {
                    let homepageService = try decoder.decode(HomepageService.self, from: data!)
                    print(homepageService)
                }
                    catch {
                        print("Error parsing the Json")
                    }
            }
        }
        datatask.resume()
    }
    
    func fetchFeeds() -> AnyPublisher<HomepageService, Error> {
        let urlString = "https://38c0eb6a-ec24-4aa3-8eaf-db9ab721a74a.mock.pstmn.io/api/v1/home"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: HomepageService.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
