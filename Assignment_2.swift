// Easy 1: array creation and access
let fruits = ["apple", "banana", "cherry", "orange", "kiwi"]
print("Third fruit: \(fruits[2])")

// Easy 2: set creation and manipulation
var favoriteNumbers: Set = [5, 12, 25, 40]
favoriteNumbers.insert(100)
print("Favorite numbers: \(favoriteNumbers)")

// Easy 3: dictionary creation and access
let releaseYears = ["Swift": 2014, "Python": 1991, "Java": 1995]
print("Swift was released in \(releaseYears["Swift"] ?? 0)")

// Easy 4: array element update
var colors = ["white", "red", "green", "yellow"]
colors[1] = "dark"
print("Updated colors: \(colors)")

// Medium 1: set intersection
let firstSet: Set = [1, 2, 3, 4]
let secondSet: Set = [3, 4, 5, 6]
print("Intersection: \(firstSet.intersection(secondSet))")

// Medium 2: dictionary update
var scores = ["Sabina": 55, "Madina": 77, "Kamila": 99]
scores.updateValue(95, forKey: "Madina")
print("Updated scores: \(scores)")

// Medium 3: array merge
let firstFruits = ["apple", "banana"]
let secondFruits = ["cherry", "date"]
let allFruits = firstFruits + secondFruits
print("Merged array: \(allFruits)")

// Hard 1: dictionary key addition
var populations = ["Kazakhstan": 20000000, "Japan": 124000000, "Norway": 5500000]
populations["Germany"] = 84000000
print("Updated populations: \(populations)")

// Hard 2: set union and subtract
let pets: Set = ["horse", "cat"]
let animals: Set = ["cat", "mouse"]
let result = pets.union(animals).subtracting(animals)
print("Final set: \(result)")

// Hard 3: nested collection
let grades = ["Sabina": [91, 83, 100], "Madina": [65, 97, 80]]
print("Madina's second grade: \(grades["Madina"]?[1] ?? 0)")