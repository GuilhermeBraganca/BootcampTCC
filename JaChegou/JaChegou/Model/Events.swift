//
//  Events.swift
//  JaChegou
//
//  Created by MacBook on 05/10/24.
//

#warning("import o foundation para usar Codable")

struct Events : Codable, Equatable {
    var data: String?
    var descricao: String?
    var unidade: String?
    var cidade: String?
    var uf: String?
}
