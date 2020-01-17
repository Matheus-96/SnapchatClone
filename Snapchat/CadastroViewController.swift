//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 17/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    
    
    @IBAction func criarConta(_ sender: Any) {
        
        //Recuperar dados digitados
        if let emailR = self.email.text {
            if let senhaR = self.senha.text {
                if let senhaConfirmacaoR = self.senhaConfirmacao.text {
                    
                    //validar senha
                    if senhaR == senhaConfirmacaoR {
                        
                        //Criar conta no firebase
                        let autenticacao = Auth.auth()
                        autenticacao.createUser(withEmail: emailR, password: senhaR) { (usuario, erro) in
                            
                            if erro == nil {
                                if usuario == nil {
                                    self.exibeMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticacao, tente novamente.")
                                } else {
                                    //redireciona usuario para tela principal
                                    self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                }
                            } else {
                                /*
                                 ERROR_INVALID_EMAIL
                                 ERROR_WEAK_PASSWORD
                                 ERROR_EMAIL_ALREADY_IN_USE
                                 */
                                let erroR = erro! as NSError
                                if let codigoErro = erroR.userInfo["FIRAuthErrorUserInfoNameKey"] {
                                    let erroTexto = codigoErro as! String
                                    var mensagemErro = ""
                                    switch erroTexto {
                                    case "ERROR_INVALID_EMAIL":
                                        mensagemErro = "E-mail inválido, digite um e-mail válido!"
                                        break
                                    case "ERROR_WEAK_PASSWORD":
                                        mensagemErro = "Senha precisa ter no mínimo 6 caracteres, com letras e números"
                                        break
                                    case "ERROR_EMAIL_ALREADY_IN_USE":
                                        mensagemErro = "Esse e-mail já está sendo utilizado, crie sua conta com outro e-mail"
                                        break
                                    default:
                                        mensagemErro = "Dados digitados estão incorretos"
                                    }
                                    self.exibeMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                                }
                            }
                            
                        } /*Fim da validacao do Firebase*/
                        
                    } else {
                        self.exibeMensagem(titulo: "Dados incorretos", mensagem: "As senhas não estão iguais, digite novamente")
                    } /* fim da validacao da senha */
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
