//
//  BreedDetailsViewController.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 03.04.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import UIKit
import WebKit
import MBCircularProgressBar

class BreedDetailsViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet private weak var webView: WKWebView!
  @IBOutlet private weak var backwardButton: UIButton!
  @IBOutlet private weak var forwardButton: UIButton!
  @IBOutlet private weak var confidenceView: MBCircularProgressBarView!
  
  var dogBreedDetail: DogBreedDetail?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupWebView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.loadWikiPage()
  }
  
  // MARK: - Actions
  
  @IBAction func backwardButtonTapped(_ sender: UIButton) {
    if self.webView.canGoBack {
      self.webView.goBack()
    }
  }
  
  @IBAction func forwardButtonTapped(_ sender: UIButton) {
    if self.webView.canGoForward {
      self.webView.goForward()
    }
  }
  
  // MARK: - Private
  
  private func setupWebView() {
    self.webView.navigationDelegate = self
    self.webView.allowsBackForwardNavigationGestures = true
  }
  
  private func updateBackwardButton() {
    self.backwardButton.isEnabled = self.webView.canGoBack
    self.backwardButton.tintColor = self.webView.canGoBack ? .link : .systemGray
  }
  
  private func updateForwardButton() {
    self.forwardButton.isEnabled = self.webView.canGoForward
    self.forwardButton.tintColor = self.webView.canGoForward ? .link : .systemGray
  }
  
  private func updateConfidenceView(confidence: CGFloat) {
    UIView.animate(withDuration: 1.0) {
      self.confidenceView.value = confidence
    }
  }
  
  private func loadWikiPage() {
    guard let breedDetail = self.dogBreedDetail else {
      self.presentAlert(message: "Invalid breed details")
      return
    }
    
    guard let url = URL(string: breedDetail.wikiURLString) else {
      self.presentAlert(message: "Could't load wiki page")
      return
    }
    
    // Load wiki page
    let request = URLRequest(url: url)
    self.webView.load(request)
    // Update the confidence value
    let confidence: CGFloat = CGFloat(breedDetail.confidence * 100)
    self.updateConfidenceView(confidence: confidence)
  }
  
  private func presentAlert(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
}

// MARK: - WKNavigationDelegate

extension BreedDetailsViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    self.updateBackwardButton()
    self.updateForwardButton()
  }
}

