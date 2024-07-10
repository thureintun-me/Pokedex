//
//  ViewController.swift
//  Pokedex
//
//  Created by ThureinTun on 01/07/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var pokemon : [Pokemon] = []
    
   
    func capitalizeText(text : String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst();
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        
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
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                self.pokemon = pokemonList.results
              
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            catch let error {
                print("erroe is \(error)")
            }
            
           
        }.resume()
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = capitalizeText(text: pokemon[indexPath.row].name) 
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSegue" {
            if let destination = segue.destination as? PokemonViewController{
                
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            }
            
            
        }
    }

}

