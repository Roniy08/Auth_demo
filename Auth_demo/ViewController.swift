//
//  ViewController.swift
//  Auth_demo
//
//  Created by Ronit Patel on 10/10/23.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController {
    // Set a Bool value in UserDefaults
  
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnUnlocked(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
       
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let localizedReason = "Authenticate to access App" // Customize this message
                if context.biometryType == .faceID {
                       // Device supports Face ID
                    // Check if biometric authentication is enabled
                       print("Face ID is available on this device")
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { success, authenticationError in
                    if success {
                        // User authenticated successfully. Proceed with Stripe Terminal operations.
                        DispatchQueue.main.async {
                            print("sucess")
                            self.lblTitle.text = "App is Unlocked"
                            self.dismiss(animated: true, completion: nil)
                            let newRootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViews")
                            newRootViewController.modalPresentationStyle = .fullScreen
                            // Access the app's UIWindow
                            if let window = UIApplication.shared.windows.first {
                                // Set the new view controller as the root view controller
                                window.rootViewController = newRootViewController
                            }
                        }
                    } else {
                        // Authentication failed or was canceled.
                        if let authError = authenticationError as? LAError {
                            switch authError.code {
                            case .userFallback:
                                self.lblTitle.text = "pressed Cancel"
                                print("pressed cancel")
//                                self.isBiometricEnabled = false
//                                UserDefaults.standard.set(self.isBiometricEnabled, forKey: "biometricEnabled")
                                break
                                // The user tapped the fallback button. You can implement a fallback mechanism here.
                            case .passcodeNotSet:
                                print("password not set")
                                break
                             case  .biometryNotEnrolled:
                                print("no authentication setup")
                                break
                            case .biometryLockout:
                                print("to many attempt")
                                break
                            default:
                                // Handle other authentication errors (e.g., show an alert).
                                break
                            }
                        }
                    }
                  }
                 } else if context.biometryType == .touchID {
                    // Device supports Touch ID
                    print("Touch ID is available on this device")
                     context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { success, authenticationError in
                         if success {
                             // User authenticated successfully. Proceed with Stripe Terminal operations.
                             DispatchQueue.main.async {
                                 print("sucess")
                                 self.lblTitle.text = "App is Unlocked"
                                 // Perform Stripe Terminal operations here.
                             }
                         } else {
                             // Authentication failed or was canceled.
                             if let authError = authenticationError as? LAError {
                                 switch authError.code {
                                 case .userFallback:
                                     self.lblTitle.text = "pressed Cancel"
                                     print("pressed cancel")
                                     break
                                     // The user tapped the fallback button. You can implement a fallback mechanism here.
                                 default:
                                     // Handle other authentication errors (e.g., show an alert).
                                     break
                                 }
                             }
                         }
                       }
             }
            } else {
                self.lblTitle.text = "Authentication not available"
                // Biometric authentication is not available on this device.
            }
    }
    
}

