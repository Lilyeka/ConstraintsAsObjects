//
//  ViewController.swift
//  ConstraintsAsObjects
//
//  Created by Лилия Левина on 15/04/2019.
//  Copyright © 2019 Лилия Левина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var v2 : UIView!
    var constraintsWith = [NSLayoutConstraint]()
    var constraintsWithout = [NSLayoutConstraint]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }

    func createViews() {
        let v1 = UIView()
        v1.backgroundColor = .red
        v1.translatesAutoresizingMaskIntoConstraints = false
        let v2 = UIView()
        v2.backgroundColor = .yellow
        v2.translatesAutoresizingMaskIntoConstraints = false
        let v3 = UIView()
        v3.backgroundColor = .blue
        v3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(v1)
        self.view.addSubview(v2)
        self.view.addSubview(v3)
        self.v2 = v2 // retain

        // construct constraints
        let c1 = NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-(20)-[v(100)]", metrics: nil, views: ["v":v1])
        let c2 = NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-(20)-[v(100)]", metrics: nil, views: ["v":v2])
        let c3 = NSLayoutConstraint.constraints(withVisualFormat:
            "H:|-(20)-[v(100)]", metrics: nil, views: ["v":v3])
        let c4 = NSLayoutConstraint.constraints(withVisualFormat:
            "V:|-(100)-[v(20)]", metrics: nil, views: ["v":v1])
        let c5with = NSLayoutConstraint.constraints(withVisualFormat:
            "V:[v1]-(20)-[v2(20)]-(20)-[v3(20)]", metrics: nil,
                                                  views: ["v1":v1, "v2":v2, "v3":v3])
        let c5without = NSLayoutConstraint.constraints(withVisualFormat:
            "V:[v1]-(20)-[v3(20)]", metrics: nil, views: ["v1":v1, "v3":v3])
        // apply common constraints
        NSLayoutConstraint.activate([c1, c3, c4].flatMap{$0})
        // first set of constraints (for when v2 is present)
        self.constraintsWith.append(contentsOf:c2)
        self.constraintsWith.append(contentsOf:c5with)
        // second set of constraints (for when v2 is absent)
        self.constraintsWithout.append(contentsOf:c5without)
        
        NSLayoutConstraint.activate(self.constraintsWith)
    }
    
    @IBAction func showViewsWithDifferentConstraints(_ sender: Any) {
    
        if self.v2.superview != nil {
            self.v2.removeFromSuperview()
            NSLayoutConstraint.deactivate(self.constraintsWith)
            NSLayoutConstraint.activate(self.constraintsWithout)
        } else {
            self.view.addSubview(v2)
            NSLayoutConstraint.deactivate(self.constraintsWithout)
            NSLayoutConstraint.activate(self.constraintsWith)
        }
    }
}

