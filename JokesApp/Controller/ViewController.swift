//
//  ViewController.swift
//  JokesApp
//
//  Created by Desiree on 10/13/20.
//

import UIKit

class ViewController: UIViewController {
    
    let urlString = "https://official-joke-api.appspot.com/jokes/random"
    
    
    @IBOutlet weak var jokesLabel: UILabel!
    @IBOutlet weak var punchLineLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var punchLineButton: UIButton!
    
    var myJoke: Joke?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performRequest(with: urlString)
        resetButton.layer.cornerRadius = 8
        punchLineButton.layer.cornerRadius = 8
    }
    
    @IBAction func punchlineButtonPressed(_ sender: UIButton) {
        punchLineLabel.text = myJoke?.punchline
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
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
                            let jokeData = try decoder.decode(Joke.self, from: safeData)
                            DispatchQueue.main.async { [self] in
                                myJoke = jokeData
                                jokesLabel.text = myJoke?.setup
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





