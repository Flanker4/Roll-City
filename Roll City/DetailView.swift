//
//  DetailView.swift
//  Roll City
//
//  Created by Иван Мельников on 22.12.15.
//  Copyright © 2015 Ivan Melnikov. All rights reserved.
//

import UIKit
import Parse

class DetailView: UIViewController {

    var currentObject : PFObject?

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var opysanie: UITextView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentObject)
      //  print(currentObject!["name"])
        
        if let object = currentObject {
            guard let nameS         = object["name"] as? String ,
                      opisanieS     = object["opisanie"] as? String,
                      priceS        = object["price"] as? Int else {
                  //что то не так с объектом
                  return
            }
            name.text = nameS
            opysanie.text = opisanieS
            price.text = "\(priceS)"
            print(name)
            print(opysanie)
            print(price)
        }
        

        
        
        
        
    }
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
