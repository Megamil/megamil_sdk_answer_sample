//
//  SDKModel.swift
//  megamil_sdk_answer_sample
//
//  Created by Eduardo dos santos on 23/10/23.
//

import Foundation

/// - parameter token: Token para uso do SDK [Obrigatório], para somente testar pode passar qualquer valor.
/// - parameter title: Título que é exibido na tela
/// - parameter aiName: Nome para IA, aparece no inicio da resposta. [Minha IA] Resposta...
/// - parameter primaryColor: Hexadecimal para cor primária
/// - parameter secondaryColor: Hexadecimal para cor secundária
/// - parameter placeholderInput: Texto temporário que aparece no campo de digitação
/// - parameter showAppBar: Exibir navigation?
/// - parameter listSuggestions: Lista de String com sugestões para tópicos ou perguntas.
/// - parameter listMessages: Histórico de mensagens, com Hora do envio, mensagem e flag para saber quem enviou a mensagem.
class SDKModel: Codable {
    
    var token: String
    var title: String?
    var aiName: String?
    var primaryColor: String?
    var secondaryColor: String?
    var placeholderInput: String?
    var showAppBar: Bool?
    var listSuggestions: [String]?
    let listMessages: [ChatMessage]?
    
    enum CodingKeys: String, CodingKey {
        case token
        case title
        case aiName
        case primaryColor = "primary_color"
        case secondaryColor = "secondary_color"
        case placeholderInput = "placeholder_input"
        case showAppBar = "show_app_bar"
        case listSuggestions = "list_suggestions"
        case listMessages = "list_messages"
    }
    
    init(token: String, title: String? = nil, aiName: String? = nil, primaryColor: String? = nil, secondaryColor: String? = nil, placeholderInput: String? = nil, showAppBar: Bool? = true, listSuggestions: [String]? = nil, listMessages: [ChatMessage]? = nil) {
        self.token = token
        self.title = title
        self.aiName = aiName
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.placeholderInput = placeholderInput
        self.showAppBar = showAppBar
        self.listSuggestions = listSuggestions
        self.listMessages = listMessages
    }
    
    static func decode(from json: Data) throws -> SDKModel {
        let decoder = JSONDecoder()
        return try decoder.decode(SDKModel.self, from: json)
    }
    
    func encode() -> String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error encoding SDKModel: \(error)")
            return nil
        }
    }
    
    func showData() {
        print("Token: \(self.token)")
        print("Title: \(self.title ?? "N/A")")
        print("AI Name: \(self.aiName ?? "N/A")")
        print("Primary Color: \(self.primaryColor ?? "N/A")")
        print("Secondary Color: \(self.secondaryColor ?? "N/A")")
        print("Placeholder Input: \(self.placeholderInput ?? "N/A")")
        print("Show App Bar: \(self.showAppBar ?? true)")
        
        if let listSuggestions = self.listSuggestions, !listSuggestions.isEmpty {
            print("List Suggestions: \(listSuggestions)")
        } else {
            print("List Suggestions: N/A")
        }
        
        if let listMessages = self.listMessages, !listMessages.isEmpty {
            print("List Messages:")
            for message in listMessages {
                message.showMessage()
            }
        } else {
            print("List Messages: N/A")
        }

    }
    
}

/// - parameter time: Horário da mensagem
/// - parameter message: Texto da mensagem
/// - parameter isAI: É uma mensagem da AI?
class ChatMessage: Codable {
    
    let time: String
    let message: String
    let isAI: Bool
    
    enum CodingKeys: String, CodingKey {
        case time
        case message
        case isAI
    }
    
    init(time: String, message: String, isAI: Bool) {
        self.time = time
        self.message = message
        self.isAI = isAI
    }
    
    static func decode(from json: Data) throws -> ChatMessage {
        let decoder = JSONDecoder()
        return try decoder.decode(ChatMessage.self, from: json)
    }
    
    func encode() -> String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error encoding ChatMessage: \(error)")
            return nil
        }
    }
    
    func showMessage() {
        let sender = self.isAI ? "AI" : "User"
        print("[\(self.time)] \(sender): \(self.message)")
    }
    
}
