//
//  Mainview.swift
//  Auth_demo
//
//  Created by Ronit Patel on 11/10/23.
//

import UIKit
import LocalAuthentication
class Mainview: UIViewController {

    var isBiometricEnabled : Bool = false // or false, depending on condition
    @IBOutlet weak var switchAction: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let isBiometricEnabled = UserDefaults.standard.value(forKey: "biometricEnabled") as? Bool {
            if isBiometricEnabled == true
            {
                switchAction.setOn(true, animated: true)
            }
            else
            {
                switchAction.setOn(false, animated: true)
            }
        }
        else
        {
            switchAction.setOn(false, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    func enableAuth()
    {
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
                            self.dismiss(animated: true, completion: nil)
//                            dismiss(animated: true, completion: nil)
                            self.isBiometricEnabled = true
                            UserDefaults.standard.set(self.isBiometricEnabled, forKey: "biometricEnabled")
                            UserDefaults.standard.synchronize()
                        }
                    } else {
                        // Authentication failed or was canceled.
                        if let authError = authenticationError as? LAError {
                            switch authError.code {
                            case .userFallback:
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
                                 // Perform Stripe Terminal operations here.
                             }
                         } else {
                             // Authentication failed or was canceled.
                             if let authError = authenticationError as? LAError {
                                 switch authError.code {
                                 case .userFallback:
                                     print("pressed Cancel")
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
                let errorString = error?.localizedDescription
                let alertController = UIAlertController(
                      title: "Alert",
                      message: "\(errorString!)",
                      preferredStyle: .alert
                  )

                  // Create an alert action
                  let okayAction = UIAlertAction(
                      title: "OK",
                      style: .default,
                      handler: { (action) in
                          // Handle the OK button tap (if needed)
                      }
                  )

                  // Add the action to the alert controller
                  alertController.addAction(okayAction)

                  // Present the alert
                  present(alertController, animated: true, completion: nil)
                print("Authentication not available")
                // Biometric authentication is not available on this device.
            }
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("turn on switch status")
            switchAction.setOn(true, animated: true)
            isBiometricEnabled = true
            self.enableAuth()
            // Add code to handle the switch being ON
        } else {
            print("turn off switch status")
            switchAction.setOn(false, animated: true)
            isBiometricEnabled = false
            UserDefaults.standard.set(self.isBiometricEnabled, forKey: "biometricEnabled")
            UserDefaults.standard.synchronize()
            let viewControllerToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViews")
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = viewControllerToPresent
            // Switch is turned off
            // Add code to handle the switch being OFF
        }
        // Switch is turned on
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
