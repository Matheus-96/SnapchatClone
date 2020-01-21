//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 17/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    @IBAction func entrar(_ sender: Any) {
        
        //Recuperar dados digitados
        if let emailR = self.email.text{
            if let senhaR = self.senha.text {
                //Autenticar usuário no Firebase
                
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR) { (usuario, erro) in
                    if erro == nil {
                        if usuario == nil {
                            self.exibeMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente.")
                        } else {
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                        
                    } else {
                        self.exibeMensagem(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente!")
                    }
                }

            }
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func exibeMensagem(titulo:String, mensagem:String){
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
