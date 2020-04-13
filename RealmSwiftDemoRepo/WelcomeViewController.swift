//
//  WelcomeViewController.swift
//  RealmSwiftDemoRepo
//
//  Created by Abhishek Kashyap on 12/04/20.
//  Copyright © 2020 Abhishek Kashyap. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class WelcomeViewController : UIViewController {
    
    let usernameField = UITextField()
    let passwordField = UITextField()
    let signInButton = UIButton(type: .roundedRect)
    let signUpButton = UIButton(type: .roundedRect)
    let errorLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .white)

    var username: String? {
        get {
            return usernameField.text
        }
    }

    var password: String? {
        get {
            return passwordField.text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white
    
        // Create a view that will automatically lay out the other controls.
        let container = UIStackView();
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.alignment = .fill
        container.spacing = 16.0;
        view.addSubview(container)
        
        // Configure the activity indicator.
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        // Set the layout constraints of the container view and the activity indicator.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // This pins the container view to the top and stretches it to fill the parent
            // view horizontally.
            container.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            // The activity indicator is centred over the rest of the view.
            activityIndicator.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
        ])

        // Add some text at the top of the view to explain what to do.
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.text = "Please enter a username and password."
        container.addArrangedSubview(infoLabel)
        
        // Configure the username and password text input fields.
        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect
        container.addArrangedSubview(usernameField)

        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect
        container.addArrangedSubview(passwordField)
        
        // Configure the sign in and sign up buttons.
        signInButton.setTitle("Sign In", for: .normal);
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        container.addArrangedSubview(signInButton)
        
        signUpButton.setTitle("Sign Up", for: .normal);
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        container.addArrangedSubview(signUpButton)
        
        // Error messages will be set on the errorLabel.
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
        container.addArrangedSubview(errorLabel)

        if (SyncUser.all.count > 1) {
            // If more than one user is unexpectedly logged in, log out all of them
            for (_, user) in SyncUser.all {
                user.logOut();
            }
        } else if (SyncUser.all.count == 1) {
            // Switch to the items view, if a user is logged in
          self.navigationController!.pushViewController(
//                ItemsViewController(),
            MapViewController(),
                animated: false
            );
        }
    }

    @objc func signIn() {
        logIn(username: username!, password: password!, register: false)
    }

    @objc func signUp() {
        logIn(username: username!, password: password!, register: true)
    }

    // Log in with the username and password, optionally registering a user.
    func logIn(username: String, password: String, register: Bool) {
        print("Log in as user: \(username) with register: \(register)");
        setLoading(true);
        let creds = SyncCredentials.usernamePassword(username: username, password: password, register: register);
        SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: { [weak self](user, err) in
            self!.setLoading(false);
            if let error = err {
                // Auth error: user already exists? Try logging in as that user.
                print("Login failed: \(error)");
                self!.errorLabel.text = "Login failed: \(error.localizedDescription)"
                return;
            }
            print("Login succeeded!");
            self!.navigationController!.pushViewController(MapViewController(), animated: true);
        });
    }
    
    // Turn on or off the activity indicator.
    func setLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating();
            errorLabel.text = "";
        } else {
            activityIndicator.stopAnimating();
        }
        usernameField.isEnabled = !loading
        passwordField.isEnabled = !loading
        signInButton.isEnabled = !loading
        signUpButton.isEnabled = !loading
    }
        
    }
    
    
    
