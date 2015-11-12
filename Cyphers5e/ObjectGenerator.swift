//
//  Item.swift
//  Cyphers5e
//
//  Created by mitchell hudson on 10/9/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import GameplayKit

class ObjectGenerator {
    
    
    // Get random String from array of strings
    
    class func randomStringFromArray(array: [String]) -> String {
        let r = array.count
        let n = GKRandomSource.sharedRandom().nextIntWithUpperBound(r)
        let str = array[n]
        
        return str
    }
    
    
    // Get Random adjective
    
    class func getAdjective() -> String {
        return randomStringFromArray(adjectiveList)
    }
    
    // Get random origin 
    
    class func getOrigin() -> String {
        return randomStringFromArray(originList)
    }
    
    // Get Random type 
    
    class func getType() -> String {
        return randomStringFromArray(types)
    }
    
    
    // Get Description 
    
    class func getDescription() -> String {
        let adjective = getAdjective()
        let origin = getOrigin()
        let type = getType()
        return "\(adjective) \(origin) \(type)"
    }
    
    
    
    static let adjectiveList = [
        "Ancient",
        "Burned",
        "Carved",
        "Chilling",
        "Chipped",
        "Cool",
        "Crumbling",
        "Decorated",
        "Delicate",
        "Grimy",
        "Old",
        "Ornate",
        "Plain",
        "Pristine",
        "Rough",
        "Runed",
        "Shining",
        "Smokey",
        "Smooth",
        "Warm",
        "Worn"
    ]
        
    static let originList = [
        "arcane",
        "astral",
        "abyssal",
        "dark elven",
        "divine",
        "draconic",
        "dwarven",
        "elemental",
        "elven",
        "ethereal",
        "ghoulish",
        "gnomish",
        "goblinoid",
        "gothic",
        "hellish",
        "orcish",
        "otherworldly",
        "prehistoric",
        "royal",
        "shadow",
        "undead",
        "unholy",
        "vampiric"
    ]
        
    static let types = [
        "amulet",
        "arrowhead",
        "bell",
        "bird skull",
        "bone",
        "bowl",
        "bracelet",
        "brooch",
        "candle",
        "coin",
        "crown",
        "cup",
        "dagger",
        "earring",
        "figurine",
        "finger bone",
        "flute",
        "gemstone",
        "glove",
        "hammer",
        "idol",
        "jewelry box",
        "key",
        "lamp",
        "mask",
        "mirror",
        "necklace",
        "opal",
        "orb",
        "pipe",
        "quill",
        "ring",
        "rod",
        "skull",
        "sphere",
        "statue",
        "stone",
        "tiara",
        "tooth"
    ]
}