import Foundation

struct CharacterDetailsViewModel {
    let name: String
    let occupation: String
    let status: String
    let nickname: String
    let seasonAppearance: String
    let imageURLString: String
    
    init(model: CharacterModel) {
        name = "Name: \(model.name)"
        occupation = "Occupation: \(model.occupation.joined(separator: ", "))"
        status = "Status: \(model.status)"
        nickname = "Nickname: \(model.nickname)"
        seasonAppearance = "Season appearance: \(model.appearance?.compactMap{ "\($0)"}.joined(separator: ", ") ?? "none")"
        imageURLString = model.imageURLString
    }
}
