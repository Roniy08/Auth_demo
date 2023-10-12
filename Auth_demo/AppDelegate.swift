//
//  AppDelegate.swift
//  Auth_demo
//
//  Created by Ronit Patel on 10/10/23.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let myViewController = Mainview()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let isBiometricEnabled = UserDefaults.standard.value(forKey: "biometricEnabled") as? Bool {
            if isBiometricEnabled == false
            {
                let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViews")
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = viewControllerToPresent
            }
        }
        else{
            let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViews")
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = viewControllerToPresent
        }
        // Override point for customization after application launch.
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("background")
        if let isBiometricEnabled = UserDefaults.standard.value(forKey: "biometricEnabled") as? Bool {
            if isBiometricEnabled == true
            {
                if let rootViewController = window?.rootViewController as? UINavigationController {
                       // Create the view controller you want to present
                       let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myVCID")

                       // Present the view controller
                      viewControllerToPresent.modalPresentationStyle = .fullScreen
                       rootViewController.present(viewControllerToPresent, animated: true, completion: nil)
                    
                   }
                else
                {
                    let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myVCID")
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = viewControllerToPresent
                }
            }
            else
            {
                let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViews")
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = viewControllerToPresent
            }
         }
         else
         {
             // Key does not exist or value is not set, handle it accordingly (e.g., set a default value)
         }
     }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if let isBiometricEnabled = UserDefaults.standard.value(forKey: "biometricEnabled") as? Bool {
            if isBiometricEnabled == true
            {
                if let rootViewController = window?.rootViewController as? UINavigationController {
                       // Create the view controller you want to present
                       let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myVCID")

                       // Present the view controller
                      viewControllerToPresent.modalPresentationStyle = .fullScreen
                       rootViewController.present(viewControllerToPresent, animated: true, completion: nil)
                    
                   }
                else
                {
                    let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myVCID")
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = viewControllerToPresent
                }
            }
            else
            {
                let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViews")
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = viewControllerToPresent
            }
         }
         else
         {
             // Key does not exist or value is not set, handle it accordingly (e.g., set a default value)
         }
        }

//    func applicationDidBecomeActive(_ application: UIApplication) {
//        if let isBiometricEnabled = UserDefaults.standard.value(forKey: "biometricEnabled") as? Bool {
//            if isBiometricEnabled == true
//            {
//                if let rootViewController = window?.rootViewController as? UINavigationController {
//                       // Create the view controller you want to present
//                       let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myVCID")
//
//                       // Present the view controller
//                      viewControllerToPresent.modalPresentationStyle = .fullScreen
//                       rootViewController.present(viewControllerToPresent, animated: true, completion: nil)
//                    
//                   }
//                else
//                {
//                    let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myVCID")
//                    let appDelegate = UIApplication.shared.delegate
//                    appDelegate?.window??.rootViewController = viewControllerToPresent
//                }
//            }
//         }
//         else
//         {
//             // Key does not exist or value is not set, handle it accordingly (e.g., set a default value)
//         }
//    }

}

