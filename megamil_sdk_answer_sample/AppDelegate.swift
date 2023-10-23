//
//  AppDelegate.swift
//  megamil_sdk_answer_sample
//
//  Created by Eduardo dos santos on 23/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
            // MARK: Tela inicial.
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self)).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigationController = UINavigationController(rootViewController: view)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}
