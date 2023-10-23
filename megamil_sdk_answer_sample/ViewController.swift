//
//  ViewController.swift
//  megamil_sdk_answer_sample
//
//  Created by Eduardo dos santos on 23/10/23.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    var flutterEngine: FlutterEngine?
    var flutterMethodChannel: FlutterMethodChannel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        flutterEngine = FlutterEngine(name: Constants.engineName)
        flutterEngine!.run(withEntrypoint: nil, initialRoute: "/")
        flutterMethodChannel = FlutterMethodChannel(name: Constants.engineChannel, binaryMessenger: flutterEngine!.binaryMessenger)
        
        //Pega o retorno do SDK
        flutterMethodChannel?.setMethodCallHandler { (call, result) in
            if call.method == Constants.updateModel {
                if let jsonResult = call.arguments as? String {
                    if let jsonData = jsonResult.data(using: .utf8) {
                        do {
                            print("#### Atualização dos dados ####")
                            let messagesModel = try JSONDecoder().decode(SDKModel.self, from: jsonData)
                            print(messagesModel.showData())
                            print("#### --- ####")
                        } catch {
                            print("Erro ao fazer parse do JSON: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
    }
    
    //Exemplo simples, com histórico
    @IBAction func openChatWithHist(_ sender: Any) {

        let flutterViewController =
        FlutterViewController(engine: flutterEngine!, nibName: nil, bundle: nil)
                
        let jsonObject: SDKModel = SDKModel(
            token: "###@Token@###",
            listMessages: [
                ChatMessage(time: "19/10/2023 21:40", message: "Olá tudo bem?", isAI: false),
                ChatMessage(time: "19/10/2023 21:41", message: "[Megamil GPT iOS] Olá, tudo sim e com você?", isAI: true)
            ]
        )

        let jsonString = jsonObject.encode()
        flutterMethodChannel!.invokeMethod(Constants.directChat, arguments: jsonString)
        
        flutterViewController.modalTransitionStyle = .crossDissolve
        flutterViewController.modalPresentationStyle = .fullScreen
        self.present(flutterViewController, animated: true)
        
    }
    
    //Exemplo completo, com sugestões.
    @IBAction func openScreenWithSuggestions(_ sender: Any) {
        
        let flutterViewController =
        FlutterViewController(engine: flutterEngine!, nibName: nil, bundle: nil)
        
        let jsonObject: SDKModel = SDKModel(
            token: "###@Token@###",
            title: "Megamil Answer Bot",
            aiName: "Megamil GPT iOS",
            primaryColor: "FFA500",
            secondaryColor: "1E90FF",
            placeholderInput: "Me pergunte qualquer coisa",
            showAppBar: true,
            listSuggestions: [
                "❓ Qual é o horário de funcionamento?",
                "🛍️ Qual é o passo a passo para realizar uma compra pelo app?",
                "🕒 Qual é o prazo para devolução?",
                "⏰ Meu pedido ainda não chegou e já passou do prazo. O que devo fazer?",
                "🙅‍♀️ Meu pedido veio errado. Como posso resolver isso?"
            ],
            listMessages: []
        )
        
        let jsonString = jsonObject.encode()
        flutterMethodChannel!.invokeMethod(Constants.emptyChat, arguments: jsonString)
        
        flutterViewController.modalTransitionStyle = .coverVertical
        flutterViewController.modalPresentationStyle = .fullScreen
        self.present(flutterViewController, animated: true)
        
    }
 
}
