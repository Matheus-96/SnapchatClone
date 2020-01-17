//
//  ViewController.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 17/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let autenticacao = Auth.auth()
//        do {
//            try autenticacao.signOut()
//        } catch  {
//            print("Erro ao deslogar usuário")
//        }
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            
            if let usuarioLogado = usuario {
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}

