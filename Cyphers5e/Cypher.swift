//
//  Cypher.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/10/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation


// Holds a Cypher with spell effect 

class Cypher {
  let name: String!
  let objectDescription: String!
  let spellEffect: Spell!
  let cost: Int!
  
  init(name: String, objectDescription: String, spellEffect: Spell) {
    self.name = name
    self.objectDescription = objectDescription
    self.spellEffect = spellEffect
    self.cost = spellEffect.getCostForSpellLevel(level: spellEffect.level)
  }
  
  // TODO: Output HTML text
  func getHTMLDescription() -> String {
    let description = objectDescription ?? "No Description"
    let effect = spellEffect.description() 
    
    return "<h1>\(description).</h1> Casts \(effect)"
  }
  
  // TODO: Output plain text
  func getPlainTextDescription() -> String {
    return "\(objectDescription). Casts \(spellEffect.descriptionPlainText())"
  }
}
