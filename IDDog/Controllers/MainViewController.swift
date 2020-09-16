//
//  ViewController.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 22.02.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import UIKit
import TableViewReloadAnimation

class MainViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var placeholderLabel: UILabel!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  
  private let galleryImagePicker = UIImagePickerController()
  private let cameraImagePicker = UIImagePickerController()
  private let queue = OperationQueue()
  
  private var currentDogBreedDetail: DogBreedDetail?
  private var breedDetails = [DogBreedDetail]()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupGalleryImagePicker()
    self.setupCameraImagePicker()
    self.setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.activityIndicator.stopAnimating()
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == K.SegueID.mainVC2BreedDetailsVC {
      let destinationVC = segue.destination as! BreedDetailsViewController
      destinationVC.dogBreedDetail = self.currentDogBreedDetail
    }
  }
    
  // MARK: - Actions
  
  @IBAction func galleryButtonTapped(_ sender: UIBarButtonItem) {
    self.present(self.galleryImagePicker, animated: true, completion: nil)
  }
  
  @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
    self.present(self.cameraImagePicker, animated: true, completion: nil)
  }
  
  // MARK: - Private
  
  private func setupGalleryImagePicker() {
    self.galleryImagePicker.delegate = self
    self.galleryImagePicker.allowsEditing = false
    self.galleryImagePicker.sourceType = .photoLibrary
  }
  
  private func setupCameraImagePicker() {
    self.cameraImagePicker.delegate = self
    self.cameraImagePicker.allowsEditing = false
    self.cameraImagePicker.sourceType = .camera
  }
  
  private func setupTableView() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.tableView.register(
      UINib(nibName: K.Nib.dogBreedCellNib, bundle: nil),
      forCellReuseIdentifier: K.Cell.dogBreedCell)
  }
  
  private func presentAlert(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
  
  private func setUIToDefault() {
    self.placeholderLabel.text = "No Image to Recognize"
    self.placeholderLabel.isHidden = false
  }
}

// MARK: - UINavigationControllerDelegate & UIImagePickerControllerDelegate

extension MainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
  {
    // Pick the image
    guard let pickedImage = info[.originalImage] as? UIImage else {
      self.setUIToDefault()
      self.presentAlert(message: "Couldn't pick the image")
      return
    }
    
    // Convert the picked image to CIImage type
    guard let ciImage = CIImage(image: pickedImage) else {
      self.setUIToDefault()
      self.presentAlert(message: "Couldn't convert the picked image")
      return
    }
    
    // Try to detect the image
    picker.dismiss(animated: true) {
      let operation = DogBreedRecognizeOperation(image: ciImage)
      self.activityIndicator.startAnimating()
      self.placeholderLabel.text = "Processing image..."
      operation.completionBlock = {
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          #warning("Move to a separate method")
          self.activityIndicator.stopAnimating()
          self.breedDetails = operation.dogBreedDetails
          if self.breedDetails.isEmpty {
            self.setUIToDefault()
            self.presentAlert(message: "Couldn't recognize a dog breed")
          } else {
            self.placeholderLabel.isHidden = true
            self.tableView.reloadData(
              with: .simple(duration: 0.75, direction: .rotation3D(type: .daredevil),
                            constantDelay: 0))
          }
        }
      }
      self.queue.addOperation(operation)
    }
  }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.breedDetails.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let breedDetail = self.breedDetails[indexPath.row]
    let cell = tableView.dequeueReusableCell(
      withIdentifier: K.Cell.dogBreedCell, for: indexPath) as! DogBreedTableViewCell
    cell.confidenceView.value = CGFloat(breedDetail.confidence * 100)
    cell.breedNameLabel.text = breedDetail.breedName
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.currentDogBreedDetail = self.breedDetails[indexPath.row]
    self.performSegue(withIdentifier: K.SegueID.mainVC2BreedDetailsVC, sender: self)
  }
}
