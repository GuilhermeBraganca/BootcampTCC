//
//  LoginModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//


// Model: Responsável por apresentar a estrutura de dados.
import Foundation

//LoginModel é um modelo para armazenamento das credencias do login do usuário.
struct LoginModel {
    var email: String
    var password: String
}

//RecoverPasswordModel é um modelo para armazenar o e-mail do usuário para recuperar a senha.
struct RecoverPasswordModel {
    var email: String
}
