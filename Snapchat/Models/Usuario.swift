//
//  Usuario.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 20/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import Foundation

class Usuario {
    
    var email : String
    var nome: String
    var uid : String
    
    init (email:String, nome:String, uid:String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
