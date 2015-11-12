//
//  CypherGenerator.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/19/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation

class CypherGenerator {
    
    let spellList = SpellList()
    
    func makeCypher() -> Cypher {
        let spell = spellList.getRandomSpellWeightedForLevel()
        let description = ObjectGenerator.getDescription()
        let cypher = Cypher(name: "", objectDescription: description, spellEffect: spell)
        return cypher
    }
    
    
}