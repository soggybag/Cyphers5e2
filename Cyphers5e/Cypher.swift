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
        self.cost = spellEffect.getCostForSpellLevel(spellEffect.level)
    }
    
    // TODO: Output HTML text
    func getHTMLDescription() -> String {
        return "<h1>\(objectDescription).</h1> Casts \(spellEffect.description())"
    }
    
    // TODO: Output plain text
    func getPlainTextDescription() -> String {
        return "\(objectDescription). Casts \(spellEffect.descriptionPlainText())"
    }
}