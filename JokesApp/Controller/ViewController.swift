//
//  ViewController.swift
//  JokesApp
//
//  Created by Desiree on 10/13/20.
//

import UIKit

class ViewController: UIViewController {
    let urlString = "https://official-joke-api.appspot.com/jokes/ten"
    var jokesArray = [Joke]()
    var i = 0
    
    @IBOutlet weak var jokesLabel: UILabel!
    
    @IBOutlet weak var punchLineLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        performRequest(with: urlString)
    }
    
    
    @IBAction func punchlineButtonPressed(_ sender: UIButton) {
        punchLineLabel.text = jokesArray[i].punchline
        i = Int.random(in: 0...jokesArray.count - 1)
        
    }
    
    @IBAction func ResetButtonPressed(_ sender: UIButton) {
        performRequest(with: urlString)
        punchLineLabel.text = ""
        
        
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print(e.localizedDescription)
                }
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            
                            let jokeData = try decoder.decode([Joke].self, from: safeData)
                            DispatchQueue.main.async { [self] in
                                jokesArray = jokeData
                                jokesLabel.text = jokesArray[i].setup
                            }
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                     
                    }
            }
            
            task.resume()
        }
        
        
    }
    
}

