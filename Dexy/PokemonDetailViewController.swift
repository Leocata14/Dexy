//
//  PokemonDetailViewController.swift
//  Dexy
//
//  Created by Jason Leocata on 15/06/2016.
//  Copyright © 2016 Jason Leocata. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!

    //@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!
    @IBOutlet weak var pokemonBio: UITextView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var nextEvo: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSprite.image = UIImage(named: "\(pokemon.pokedexId)")
        pokemon.downloadPokemonDetails { () -> () in
            //Called after downloading is down
            
            self.updateUI()
        }
        
        //nameLabel.text = pokemon.name
    }
    
    func updateUI() {
        pokemonBio.text = pokemon.bio
        typeLabel.text = pokemon.type
        idLabel.text = "#\(pokemon.pokedexId)"
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
