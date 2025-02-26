//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Caio Marastoni on 18/02/25.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButtom = UIButton(type: .system)
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingContentViewController(imageOnboarding: "delorean", titleText: "Bankey is faster, easier to use and has a brand new look that will make you feel like you are back into the future.")
        let page2 = OnboardingContentViewController(imageOnboarding: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingContentViewController(imageOnboarding: "thumbs", titleText: "Learn more at www.bankey.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        
    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(closeButtom)
        
        //PageViewController
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        
        currentVC = pages.first!
    }
    
    private func style() {
        
        //CLOSE BUTTOm
        closeButtom.translatesAutoresizingMaskIntoConstraints = false
        closeButtom.setTitle("Close", for: [])
        closeButtom.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
    }
    
    private func layout() {
        
        //PAGE VIEW
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
            
        ])
        
        //CLOSE BUTTOM
        NSLayoutConstraint.activate([
            closeButtom.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: closeButtom.trailingAnchor, multiplier: 2)
        ])
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

//MARK: - Actions
extension OnboardingViewController{
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
}
