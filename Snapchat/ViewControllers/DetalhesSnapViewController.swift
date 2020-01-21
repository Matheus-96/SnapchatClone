//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 21/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var detalhes: UILabel!
    @IBOutlet weak var contador: UILabel!
    
    var snap = Snap()
    var tempo = 11

    override func viewDidLoad() {
        super.viewDidLoad()
        print(snap.urlImagem)
        detalhes.text = "Carregando..."
        let url = URL(string: snap.urlImagem)
        imagem.sd_setImage(with: url) { (imagem, erro, cache, url) in
            if erro == nil {
                self.detalhes.text = self.snap.descricao
                //inicializar o timer
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                    //decrementar tempo
                    self.tempo = self.tempo - 1
                    
                    //exibir o timer
                    self.contador.text = String(self.tempo)
                    
                    //caso o timer execute até o zero
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let autenticacao = Auth.auth()
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            
            //Remove nós do database
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            snaps.child(snap.identificador).removeValue()
            
            //Remove imagem do Snap
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            
            imagens.child("\(snap.idImagem).jpg").delete { (erro) in
                if erro == nil {
                    print("Sucesso ao excluir a imagem")
                } else {
                    print("Falha ao excluir a imagem")
                }
            }
        }
        
        
    }
}
