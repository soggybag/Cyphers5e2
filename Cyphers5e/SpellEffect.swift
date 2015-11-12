//
//  SpellEffect.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/10/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation


struct SpellEffect {
    let spell: Spell!
    let casterLevel: Int!
    let casterBonus: Int!
    
    init(spell: Spell, casterLevel: Int, casterBonus: Int) {
        self.spell = spell
        self.casterLevel = casterLevel
        self.casterBonus = casterBonus
    }
}