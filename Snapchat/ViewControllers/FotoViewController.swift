//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 17/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var botaoProximo: UIButton!
    
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString
    
    @IBAction func selecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        let imagemArquivo = imagens.child("\(idImagem).jpg") /* diferente do jamilton*/
        
        //Recuperar a imagem
        if let imagemSelecionada = imagem.image {
            if let imagemDados = imagemSelecionada.jpegData(compressionQuality: 0.1) {
                imagemArquivo.putData(imagemDados, metadata: nil) { (metaDados, erro) in
                    
                    if erro == nil {
                        print("sucesso ao fazer o uploado do arquivo")
                        
                        /* diferente do jamilton*/
                        imagemArquivo.downloadURL { (url, error) in
                            print((url?.absoluteString)!)
                            self.performSegue(withIdentifier: "selecionarUsuarioSegue", sender: url)
                            
                        }
                        
                        
                                  
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                    } else {
                        let alerta = Alerta(titulo: "Upload falhou", mensagem: "Erro ao salvar o arquivo, tente novamente!")
                        self.present(alerta.getAlerta(), animated: true, completion: nil)
                    }
                    
                }
            }
            
        }
        
    }
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //desabiblita o botao
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage ] as! UIImage
        imagem.image = imagemRecuperada
        
        //habilita botao proximo
        self.botaoProximo.isEnabled = true
        self.botaoProximo.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
