// Step 1: personal information
let firstName = "Sabina"
let lastName = "Murzabayeva"
let birthYear = 2005
let currentYear = 2026
let age = currentYear - birthYear
let isStudent = true
let height = 1.72
let city = "Almaty"
let university = "KBTU"
let yearOfStudy = 4

// Step 2: hobbies and interests
let hobby = "volleyball, computer games"
let numberOfHobbies = 2
let favoriteNumber = 5
let isHobbyCreative = true
let ikuLanguage = "turkish"
let fc = "Korean"
let likesCats = true

// Bonus: future goals and emoji
let futureGoals = "become a professional volleyball player"
let 🎯 = "win CKR"
let mood = "😜"
let favoriteEmoji = "😭"

// Step 3: life story with string interpolation
let lifeStory = "My name is \(firstName) \(lastName). I am \(age) years old, born in \(birthYear). "
    + "I am currently \(isStudent ? "a student" : "not a student") at \(university) in \(city), year \(yearOfStudy). "
    + "My height is \(height) m. "
    + "I enjoy \(hobby), which is \(isHobbyCreative ? "a creative" : "not a creative") hobby. "
    + "I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber). "
    + "My favorite language is \(ikuLanguage), and my favorite cusine \(fc) . "
    + "\(likesCats ? "I love cats. " : "")"
    + "In the future, I want to \(futureGoals) and \(🎯). \(mood) \(favoriteEmoji)"

// Step 4: print the result
print(lifeStory)