//
//  Pokemon.swift
//  Dexy
//
//  Created by Jason Leocata on 15/06/2016.
//  Copyright © 2016 Jason Leocata. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _bio: String!//
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _pokemonUrl: String!
    
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var bio: String {
        if _bio == nil {
            _bio = ""
        }
        return _bio
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense 
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? Int {
                    self._weight = "\(weight)"
                }
                if let height = dict["height"] as? Int {
                    self._height = "\(height)"
                }
                if let base_stats = dict["stats"] as? [Dictionary<String, AnyObject>] {
                    
                    if let attack = base_stats[4] as? Dictionary<String, AnyObject> {
                        if let base_attack = attack["base_stat"]{
                            self._attack = "\(base_attack)"
                        }
                    }
                    if let defense = base_stats[3] as? Dictionary<String, AnyObject> {
                        if let base_defense = defense["base_stat"] {
                            self._defense = "\(base_defense)"
                        }
                        
                    }
                    
                }
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] where types.count > 0 {
                    if let type = types[0]["type"] as? Dictionary<String, AnyObject> {
                        if let name = type["name"] {
                            self._type = "\(name.capitalizedString)"
                        }
                    }
                    
                    if types.count > 1 {
                        //Need to sort array by Slot number here
                        
                        
                        for x in 1 ..< types.count {
                            if let type = types[x]["type"] as? Dictionary<String, AnyObject>  {
                                
                                if let name = type["name"] {
                                    self._type! += " / \(name.capitalizedString)"
                                }
                            }
                        }
                        
                    }
                } else {
                    self._type = ""
                }
                print(self._type)

                
                if let species = dict["species"] as? Dictionary<String, AnyObject> {
                    print(species)
                    if let nurl = species["url"] as? String  {
                        print(nurl)
                        let nsurl = NSURL(string: nurl)!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let desResult = response.result
                            if let descArray = desResult.value as? Dictionary<String,AnyObject>  {
                                if let flavArr = descArray["flavor_text_entries"] as? [Dictionary<String,AnyObject>] where flavArr.count > 0 {
                                    if let text = flavArr[1] as? Dictionary<String,AnyObject> {
                                        if let bio = text["flavor_text"] {
                                            print(bio)
                                            self._bio = "\(bio)"
                                        }
                                    }
                                    completed()
                                }
                                
/* Evolution Chain code
                                if let evoChain = descArray["evolution_chain"] as? Dictionary<String,AnyObject> {
                                    if let evoChainUrl = evoChain["url"] as? String {
                                        print(evoChainUrl)
                                        let chainUrl = NSURL(string: evoChainUrl)!
                                        Alamofire.request(.GET, chainUrl).responseJSON { response in
                                            let chainResult = response.result
                                            if let chainDict = chainResult.value as? Dictionary<String,AnyObject> {
                                                if let chain = chainDict["chain"] as? Dictionary<String,AnyObject> {
                                                    //print(chain)
                                                    if let evolvesTo = chain["evolves_to"] as? [Dictionary<String,AnyObject>] {
                                                        
                                                        if let nextEvo = evolvesTo[0]["species"] as? Dictionary<String,AnyObject> {
                                                            //print(nextEvo)
                                                            if let name = nextEvo["name"] as? String {
                                                                print(name.capitalizedString)
                                                            }
                                                        }
                                                        
                                                        if let evoDetails = evolvesTo[0]["evolution_details"] as? [Dictionary<String,AnyObject>] {
                                                            print(evoDetails)
                                                            if let trigger = evoDetails[0]["trigger"] as? Dictionary<String,AnyObject> {
                                                                if let triggerDesc = trigger["name"] as? String {
                                                                    print(triggerDesc)
                                                                }
                                                            }
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        
                                        }
                                    }
                                }
*/
                            } else {
                                self._bio = ""
                            }
                            
                        }
                    }
                    
                    
                    
                } else {
                    self._bio = ""
                }
                
                
                
                
                

            }
        }
        
        
    }
    
}