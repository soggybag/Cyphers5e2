//
//  Spell.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/7/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import GameplayKit

class Spell {
  let name: String
  let level: Int
  let castAtHigherLevel: Bool
  let hasDC: Bool
  let hasAttack: Bool
  let pagePHB: Int
  
  var casterLevel: Int!
  var casterBonus: Int!
  var spellDC: Int!
  
  
  // MARK: - Output spell description
  
  // Spell with HTML formatting
  
  func description() -> String {
    var str = "<strong>\(name)</strong> <br>("
    if hasDC || hasAttack || castAtHigherLevel {
      str += "Cast at level \(level); "
    }
    
    if castAtHigherLevel {
      str += "caster level \(casterLevel); "
    }
    
    if hasDC {
      str += "Save DC \(spellDC); "
    }
    
    if hasAttack {
      str += "spell attack \(casterBonus); "
    }
    
    str += "PHB pg \(pagePHB)); "
    
    str += "<br>Cost: \(getCostForSpellLevel(level: level))gp."
    
    return str
  }
  
  
  // Spell in plain text
  
  func descriptionPlainText() -> String {
    var str = "\(name)\n("
    if hasDC || hasAttack || castAtHigherLevel {
      str += "Cast at level \(level); "
    }
    
    if castAtHigherLevel {
      str += ", caster level \(casterLevel); "
    }
    
    if hasDC {
      str += ". Save DC \(spellDC); "
    }
    
    if hasAttack {
      str += "spell attack \(casterBonus); "
    }
    
    str += "PHB pg \(pagePHB)); "
    
    str += "Cost: \(getCostForSpellLevel(level: level))gp"
    
    return str
  }
  
  
  
  func randomRange(range: Int) -> Int {
    return GKRandomSource.sharedRandom().nextInt(upperBound: range)
    // return GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
  }
  
  func getRandomSpellLevelWeightedForRoll(roll: Int) -> Int {
    if roll < 10 {
      return 0
    } else if roll < 25 {
      return 1
    } else if roll < 40 {
      return 2
    } else if roll < 55 {
      return 3
    } else if roll < 70 {
      return 4
    } else if roll < 85 {
      return 5
    } else if roll < 90 {
      return 6
    } else if roll < 95 {
      return 7
    } else if roll < 98 {
      return 8
    } else {
      return 9
    }
  }
  
  func getCasterLevel() -> Int {
    let n = randomRange(range: 100)
    let l = (getRandomSpellLevelWeightedForRoll(roll: n) * 2) + (n % 2)
    if l <= level * 2 {
      return level * 2
    }
    return l
  }
  
  
  
  
  // MARK: Cost
  
  func getCostForSpellLevel(level: Int) -> Int {
    
    switch level {
    case 0 :
      return 100
      
    case 1..<5 :
      return level * 100
      
    case 5..<11 :
      return 2500 * level / 10
      
    default :
      return 25000 * level / 16
    }
  }
  
  
  
  init(name: String, level: Int, castAtHigherLevel: Bool, hasDC: Bool, hasAttack: Bool, pagePHB: Int) {
    self.name = name
    self.level = level
    self.castAtHigherLevel = castAtHigherLevel
    self.hasDC = hasDC
    self.hasAttack = hasAttack
    self.pagePHB = pagePHB
    self.casterLevel = self.getCasterLevel()
    self.casterBonus = randomRange(range: self.casterLevel / 3) + 4
    self.spellDC = self.casterBonus + 8
  }
}
