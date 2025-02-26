//
//  SceneDelegate.swift
//  Bankey
//
//  Created by Caio Marastoni on 04/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = loginViewController
        
    }

}

extension SceneDelegate: LoginViewControllerDelegate, OnboardingViewControllerDelegate {
    func didLogin() {
        setNextViewController(onboardingViewController)
        
    }
    
    func didFinishOnboarding() {
        print("Did finish onboarding")
    }
}

extension SceneDelegate {
    func setNextViewController (_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
            
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

