//
//  SpellList.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/7/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import GameplayKit

class SpellList {
  
  
  // Hold spells
  
  var spellList = [Spell]()
  var spellListBylevel = [[Spell]]()
  
  
  // Get a Cypher 
  
  func getCypher() -> String {
    let spell = self.getRandomSpellWeightedForLevel()
    let description = ObjectGenerator.getDescription()
    
    return "<h1>\(description)</h1> Casts \(spell.description())"
  }
  
  
  // Build spell list
  func getSpells(spellList: NSArray) {
    
    for spell in spellList {
      let name = spell["name"] as! String
      let level = Int((spell["level"] as! String))!
      let castAtHigherLevel = Int((spell["castAtHigherLevel"] as! String))!.toBool()!
      let hasDC = Int((spell["hasDC"] as! String))!.toBool()!
      let hasAttack = Int((spell["hasAttack"] as! String))!.toBool()!
      let pagePHB = Int((spell["pagePHB"] as! String))!
      
      // print(name, level, castAtHigherLevel, hasDC, hasAttack, pagePHB)
      let newSpell = Spell(name: name, level: level, castAtHigherLevel: castAtHigherLevel, hasDC: hasDC, hasAttack: hasAttack, pagePHB: pagePHB)
      self.spellList.append(newSpell)
    }
  }
  
  
  // Organize spells into arrays by level
  func organizeSpellsByLevel() {
    // Find highest level spell
    var maxLevel = 0
    for spell in self.spellList {
      if maxLevel < spell.level {
        maxLevel = spell.level
      }
    }
    
    let sortedSpellList = self.spellList.sort {$0.level < $1.level}
    
    for spell in sortedSpellList {
      if self.spellListBylevel[safe: spell.level] != nil {
        self.spellListBylevel[spell.level].append(spell)
      } else {
        self.spellListBylevel.append([spell])
      }
    }
  }
  
  
  // Return random numbers from 0 to range
  func randomRange(range: Int) -> Int {
    let n = GKRandomSource.sharedRandom().nextInt(upperBound: range)
    // let n = GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
    return n
  }
  
  
  // Get random spell from list
  func getRandomSpellFromList(list: [Spell]) -> Spell {
    return list[randomRange(range: list.count)]
  }
  
  // Get a random spell of Level
  func getRandomSpellOfLevel(level: Int) -> Spell {
    return self.getRandomSpellFromList(list: self.spellListBylevel[level])
  }
  
  
  // Log a spell 
  func logSpell(spell: Spell) {
    print("\(spell.name) \(spell.level)")
  }
  
  
  // Load Data from plist
  
  func loadDataFromPlist(plist: String) -> NSArray? {
    if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
      return NSArray(contentsOfFile: path)
    }
    return nil
  }
  
  
  // Random Spell weighted for level 
  
  func getRandomSpellWeightedForLevel() -> Spell {
    let n = self.randomRange(range: 100)
    var level = 0
    if n < 10 {
      level = 0
    } else if n < 25 {
      level = 1
    } else if n < 40 {
      level = 2
    } else if n < 55 {
      level = 3
    } else if n < 70 {
      level = 4
    } else if n < 85 {
      level = 5
    } else if n < 90 {
      level = 6
    } else if n < 95 {
      level = 7
    } else if n < 98 {
      level = 8
    } else {
      level = 9
    }
    
    return self.getRandomSpellOfLevel(level: level)
  }
  
  
  
  init() {
    if let spellList = self.loadDataFromPlist(plist: "spells2") {
      self.getSpells(spellList: spellList)
      self.organizeSpellsByLevel()
      
      /*
       print("--- Log some random spells")
       logSpell(self.getRandomSpell())
       logSpell(self.getRandomSpell())
       logSpell(self.getRandomSpell())
       logSpell(self.getRandomSpell())
       
       print("--- Log some random 0 level spells")
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[0]))
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[0]))
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[0]))
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[0]))
       
       print("Log some random 1 level spells")
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[1]))
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[1]))
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[1]))
       logSpell(self.getRandomSpellFromList(self.spellListBylevel[1]))
       
       print("--- Log Spells of random levels weighted")
       for _ in 1...10 {
       logSpell(self.getRandomSpellWeightedForLevel())
       }
       
       
       print("--- Log random descriptions")
       for _ in 1...10 {
       print(ObjectGenerator.getDescription())
       }
       
       print("--- Log random Cyphers")
       for _ in 1...10 {
       print(self.getCypher())
       }
       */
    }
  }
  
}


// -------------------------------------------------------------------


extension Int {
  func toBool() -> Bool? {
    switch self {
    case 0:
      return false
    case 1:
      return true
    default :
      return nil
    }
  }
}


extension Array {
  subscript (safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}
