
import Foundation
import Alamofire

class FreeToGameApi {
  
  static let shared = FreeToGameApi()
  
  func fetchGamesList() async -> Result<[FreeGame], AFError> {
    let url = "https://www.freetogame.com/api/games"
    let dataTask = AF.request(url).serializingDecodable([FreeGame].self)
    let result = await dataTask.result
    return result
  }
}

public struct FreeGame: Decodable, Equatable, Identifiable {
//  "id":540,
//  "title":"Overwatch 2",
//  "thumbnail":"https:\/\/www.freetogame.com\/g\/540\/thumbnail.jpg",
//  "short_description":"A hero-focused first-person team shooter from Blizzard Entertainment.",
//  "game_url":"https:\/\/www.freetogame.com\/open\/overwatch-2",
//  "genre":"Shooter",
//  "platform":"PC (Windows)",
//  "publisher":"Activision Blizzard",
//  "developer":"Blizzard Entertainment",
//  "release_date":"2022-10-04",
//  "freetogame_profile_url":"https:\/\/www.freetogame.com\/overwatch-2"
  public let id: Int
  let title: String
  let thumbnail: String
  let short_description: String
  let game_url: String
  let genre: String
  let platform: String
  let publisher: String
  let developer: String
  let release_date: String
  let freetogame_profile_url: String
}

extension FreeGame {
  static var mock: Self {
    return FreeGame(
      id: 540,
      title: "Overwatch 2",
      thumbnail: "https://www.freetogame.com/g/540/thumbnail.jpg",
      short_description: "A hero-focused first-person team shooter from Blizzard Entertainment.",
      game_url: "https://www.freetogame.com/open/overwatch-2",
      genre: "Shooter",
      platform: "PC (Windows)",
      publisher: "Activision Blizzard",
      developer: "Blizzard Entertainment",
      release_date: "2022-10-04",
      freetogame_profile_url: "https://www.freetogame.com/overwatch-2"
    )
  }
}
