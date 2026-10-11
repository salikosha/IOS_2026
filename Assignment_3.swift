// =============================================================
//  Station ALMA-7: Rescue Protocol
//  iOS Mobile Development · Module 3 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER CODE section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Use the exact function names from the assignment PDF.
// =============================================================


// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================


// MARK: - =================== YOUR SOLUTION ===================

// MARK: Level 1 · Decoding Telemetry

func parseReading(_ raw: String) -> Reading? {
    guard let parts = splitOnce(raw, by: ":"),
          !parts.0.isEmpty,
          let value = Int(parts.1),
          value >= 0 || parts.0 == "TEMP" else {
        return nil
    }
    return (sensor: parts.0, value: value)
}

func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var valid: [Reading] = []
    var invalidCount = 0

    for line in lines {
        if let reading = parseReading(line) {
            valid.append(reading)
        } else {
            invalidCount += 1
        }
    }
    return (valid, invalidCount)
}

let parsedLog = parseLog(rawLog)
let validReadings = parsedLog.valid
let A = parsedLog.invalidCount
print("A - invalid log lines:", A)
print("Valid readings:", validReadings)


// MARK: Level 2 · Analysis

func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var result: [Reading] = []
    for reading in readings {
        if isIncluded(reading) {
            result.append(reading)
        }
    }
    return result
}

func values(of readings: [Reading]) -> [Int] {
    var result: [Int] = []
    for reading in readings {
        result.append(reading.value)
    }
    return result
}

let oxygenReadings = select(validReadings) { $0.sensor == "O2" }
print("O2 readings:", oxygenReadings)

func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard let first = values.first else { return nil }

    var smallest = first
    var largest = first
    var sum = 0

    for value in values {
        if value < smallest { smallest = value }
        if value > largest { largest = value }
        sum += value
    }

    return (min: smallest, max: largest, average: Double(sum) / Double(values.count))
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}

let oxygenStats = stats(of: values(of: oxygenReadings))
let B = Int(oxygenStats?.average ?? 0)
print("B - average O2 value:", B)
print("Example stats:", stats(3, 8, 1) as Any)
print("Empty stats:", stats() as Any)

// The same comparison is used to check all five sorting styles.
func sameReadings(_ first: [Reading], _ second: [Reading]) -> Bool {
    if first.count != second.count { return false }
    for index in 0..<first.count {
        if first[index].sensor != second[index].sensor ||
            first[index].value != second[index].value {
            return false
        }
    }
    return true
}

let sorted1 = validReadings.sorted(by: { (left: Reading, right: Reading) -> Bool in
    return left.value > right.value
})

let sorted2 = validReadings.sorted(by: { left, right in
    return left.value > right.value
})

let sorted3 = validReadings.sorted(by: { left, right in
    left.value > right.value
})

let sorted4 = validReadings.sorted(by: { $0.value > $1.value })

let sorted5 = validReadings.sorted { $0.value > $1.value }

print("Closure ladder 1:", sorted1)
print("Closure ladder 2:", sorted2)
print("Closure ladder 3:", sorted3)
print("Closure ladder 4:", sorted4)
print("Closure ladder 5:", sorted5)
let allSortsMatch = sameReadings(sorted1, sorted2)
    && sameReadings(sorted2, sorted3)
    && sameReadings(sorted3, sorted4)
    && sameReadings(sorted4, sorted5)
print("All five sorting results match:", allSortsMatch)


// MARK: Level 3 · Temperature Stabilization

func heatUp(_ t: Int) -> Int { t + 5 }
func coolDown(_ t: Int) -> Int { t - 3 }
func hold(_ t: Int) -> Int { t }

func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < 18 { return heatUp }
    if temp > 24 { return coolDown }
    return hold
}

func runUntilStable(from start: Int, maxSteps: Int = 10) -> (finalTemp: Int, steps: Int, isStable: Bool) {
    var temperature = start
    var steps = 0

    while (temperature < 18 || temperature > 24) && steps < maxSteps {
        let protocolFunction = chooseProtocol(for: temperature)
        temperature = protocolFunction(temperature)
        steps += 1
    }

    let isStable = temperature >= 18 && temperature <= 24
    return (temperature, steps, isStable)
}

print("Stabilize 31:", runUntilStable(from: 31))
print("Stabilize -100:", runUntilStable(from: -100, maxSteps: 5))

let temperatureReadings = select(validReadings) { $0.sensor == "TEMP" }
let temperatureStats = stats(of: values(of: temperatureReadings))
let lowestTemperature = temperatureStats?.min ?? 18
let C = runUntilStable(from: lowestTemperature).steps
print("Lowest valid temperature:", lowestTemperature)
print("C - steps to stabilize:", C)


// MARK: Level 4 · The Crew

func oxygenLevel(of member: CrewMember) -> Int? {
    member.module?.oxygenTank?.level
}

func status(of member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        let location = member.module?.name ?? "open space"
        return "\(member.name): no data (\(location))"
    }

    if level < 20 {
        return "\(member.name): \(level)% CRITICAL"
    }
    return "\(member.name): \(level)% OK"
}

for member in crew {
    print(status(of: member))
}

@discardableResult
func transferOxygen(from source: inout Int, to target: inout Int, amount: Int) -> Int {
    let transferable = max(0, min(amount, source, 100 - target))
    source -= transferable
    target += transferable
    return transferable
}

if let sourceTank = lab.oxygenTank, let targetTank = hab.oxygenTank {
    let moved = transferOxygen(from: &sourceTank.level, to: &targetTank.level, amount: 30)
    print("Oxygen transferred:", moved)
}
let D = hab.oxygenTank?.level ?? 0
print("D - oxygen level in Hab:", D)

func evacuationOrder(_ names: String..., roster: [String: CrewMember]) -> [String] {
    var found: [CrewMember] = []

    for name in names {
        guard let member = roster[name] else {
            print("Unknown crew member: \(name)")
            continue
        }
        found.append(member)
    }

    found.sort { $0.priority < $1.priority }

    var result: [String] = []
    for member in found {
        result.append(member.name)
    }
    return result
}

print("Evacuation order:", evacuationOrder("Dana", "Ghost", "Aigerim", "Timur", roster: roster))


// MARK: Level 5 · The Saboteur's Logbook


func reportOxygen(for member: CrewMember) -> String {
    guard let tank = member.module?.oxygenTank else {
        return "\(member.name): no oxygen data"
    }
    return "\(member.name): \(tank.level)%"
}

func firstCritical(in crew: [CrewMember]) -> String? {
    for member in crew {
        if let level = oxygenLevel(of: member), level < 20 {
            return member.name
        }
    }
    return nil
}

print(reportOxygen(for: crew[0]))
print(reportOxygen(for: crew[1]))
print("First critical crew member:", firstCritical(in: crew) as Any)


let testCrew = [
    CrewMember(name: "First", role: "Test", priority: 1, module: Module(name: "A", oxygenTank: Tank(level: 10))),
    CrewMember(name: "Second", role: "Test", priority: 2, module: Module(name: "B", oxygenTank: Tank(level: 5)))
]
print("Logic bug test (expected First):", firstCritical(in: testCrew) as Any)
print("No critical member test (expected nil):", firstCritical(in: [crew[0]]) as Any)


// MARK: Finale · Launch Code

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("LAUNCH CODE: \(launchCode)")


// MARK: Bonus

func makeAlarm(threshold: Int) -> (Int) -> Bool {
    var count = 0
    return { oxygen in
        if oxygen < threshold {
            count += 1
            print("Alarm #\(count)")
            return true
        }
        return false
    }
}

let alarm = makeAlarm(threshold: 20)
print("Alarm test 1:", alarm(12))
print("Alarm test 2:", alarm(40))
print("Alarm test 3:", alarm(5))

