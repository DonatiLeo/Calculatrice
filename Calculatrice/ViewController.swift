//
//  ViewController.swift
//  Calculatrice
//
// Created by donati on 27/02/2023.
//

import UIKit

class ViewController: UIViewController {

    var onEstAuDebutDeLaSaisie = true
    var brain = Cerveau()
      
    var valeurAffichée : Double {
        get {
            return NumberFormatter().number(from: ecran.text!)!.doubleValue
        }
        set {
            ecran.text = "\(newValue)"

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var ecran: UILabel!
    
    
    @IBAction func calcule(_ sender: UIButton) {
        brain.push(nomOperation: (sender.titleLabel?.text)!)
        if let res = brain.evaluate() {
            valeurAffichée = res
        }
        else {
            valeurAffichée = 0
        }
        print("état de la pile \(brain.pileDOp)")			
    }
    
    @IBAction func enter() {
        brain.push(operande: valeurAffichée)
        if let res = brain.evaluate() {
            valeurAffichée = res
        }
        else {
            valeurAffichée = 0
        }
        onEstAuDebutDeLaSaisie = true
        print("état de la pile \(brain.pileDOp)")
    }
    
    @IBAction func ajouteChiffre(_ sender: UIButton) {
        if let chiffre = sender.titleLabel?.text {
            if onEstAuDebutDeLaSaisie {
                ecran.text = chiffre
                onEstAuDebutDeLaSaisie = false
            }
            else {
                ecran.text = ecran.text! + chiffre
            }
        }
    }
}

