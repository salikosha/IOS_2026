import Foundation
 
struct Track {
    let title: String
    let artist: String
    let fileName: String
    let coverImageName: String
}
 
enum TrackLibrary {

    static let tracks: [Track] = [
        Track(title: "Otonoke",  artist: "Creepy Nuts",  fileName: "Creepy_Nuts_Otonoke", coverImageName: "Dandadan"),
        Track(title: "Snooze",  artist: "SZA",  fileName: "SZA - Snooze (Audio)", coverImageName: "sza"),
        Track(title: "Kyouran Hey Kids",  artist: "THE ORAL CIGARETTES",  fileName: "THE_ORAL_CIGARETTES_-_Kyouran_Hey_Kids_Full_OP_Norogami_Arogoto_(mp3.pm)", coverImageName: "noragami"),
        Track(title: "Рапсодия Конца Света",  artist: "GONE.Fludd",  fileName: "GONE.Fludd - Рапсодия Конца Света", coverImageName: "gone"),
        Track(title: "Boys",  artist: "Saluki feat Feduk, Friendly Thug 52 ngg",  fileName: "Saluki feat Feduk, Friendly Thug 52 ngg - Boys (hitmo.net)", coverImageName: "saluki"),
        Track(title: "Blood Sweat & Tears",  artist: "BTS",  fileName: "BTS", coverImageName: "bts"),
        Track(title: "Moon",  artist: "Kanye West",  fileName: "Kanye West - Moon [nmuz.net]", coverImageName: "kanye"),
        Track(title: "Gold",  artist: "Kiiara",  fileName: "Kiiara - Gold", coverImageName: "gold"),
        Track(title: "EDM",  artist: "Big Baby Tape & Aarne & Платина",  fileName: "Big Baby Tape & Aarne & Платина - EDM", coverImageName: "EDM"),
        Track(title: "FRI(END)S", artist: "V", fileName: "Kim_Taehyung_-_FRI_END_S_(mp3.pm)", coverImageName: "FRI(END)S")
    ]
}
 
