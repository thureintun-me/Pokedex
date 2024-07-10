//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by ThureinTun on 01/07/2024.
//

import UIKit

class PokemonViewController : UIViewController {
    
    @IBOutlet var nameLable : UILabel!
    @IBOutlet var numberLabel : UILabel!
    @IBOutlet var type1Label : UILabel!
    @IBOutlet var type2Label : UILabel!
    var pokemon : Pokemon!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type1Label.text = ""
        type2Label.text = ""
        let url = URL(string: pokemon.url)
        
        guard let u = url else {
            print("Invalid URL")
            return
        }
     
        print("u is \(u)")
        URLSession.shared.dataTask(with: u) { data, response, error in
            
            guard let data = data else{
                return
            }
            
            print("data is \(data)")
            
            do{
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    
                    
                    self.nameLable.text = self.pokemon.name
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                }
            }
            catch let error {
                print("erroe is \(error)")
            }
            
           
        }.resume()
        
        
       // nameLable.text = pokemon.name
     //   numberLabel.text = String(format: "#%03d",pokemon.number)
    }
    
    
}
    
