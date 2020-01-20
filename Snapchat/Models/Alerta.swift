//
//  Alerta.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 20/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit

class Alerta {
    
    var titulo:String
    var mensagem: String
    
    init(titulo:String, mensagem:String) {
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func getAlerta() -> UIAlertController {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(acaoCancelar)
        return alerta
    }
    
}
