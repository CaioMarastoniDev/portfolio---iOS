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
    let dummyViewController = DummyViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        dummyViewController.logouDelegate = self
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = loginViewController
        
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

extension SceneDelegate: LoginViewControllerDelegate, OnboardingViewControllerDelegate, LogoutDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setNextViewController(dummyViewController)
        } else {
            setNextViewController(onboardingViewController)
        }
        
        
    }
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setNextViewController(dummyViewController)
    }
    
    func didLogout() {
        setNextViewController(loginViewController)
    }
}

