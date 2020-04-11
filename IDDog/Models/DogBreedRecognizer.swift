//
//  DogBreedRecognizer.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 28.02.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import UIKit
import CoreML
import Vision


protocol DogBreedRecognizerDelegate {
  func dogBreedRecognizer(
    _ recognizer: DogBreedRecognizer,
    didFinishDetectBreedWithDetaiil dogBreedDetaiil: DogBreedDetail)
  
  func dogBreedRecognizer(
    _ recognizer: DogBreedRecognizer,
    didFinishDetectBreedWithDetails dogBreedDetails: [DogBreedDetail])
  
  func dogBreedRecognizer(
    _ recognizer: DogBreedRecognizer,
    didFinishDetectBreedWithError error: Error)
}

struct DogBreedRecognizer {
    
  // MARK: - Properties
  
  var delegate: DogBreedRecognizerDelegate?
  
  private let dogBreedDetailsManager = DogBreedDetailsManager()
  
  private let minConfidence: VNConfidence = 0.01
    
  // MARK: - Public
  
  func detect(image: CIImage) {
    // Load the model
    guard let model = try? VNCoreMLModel(for: DogBreedsImageClassifier().model) else {
      self.postCommonError()
      return
    }
    
    // Make the request
    let request = VNCoreMLRequest(model: model) { (request, error) in
      if error != nil {
        self.postCommonError()
        return
      }
      
      guard let results = request.results as? [VNClassificationObservation] else {
        self.postCommonError()
        return
      }
      
      var breedDetails = [DogBreedDetail]()
      
      for result in results {
        if result.confidence < self.minConfidence {
          break
        }
        
        let key = result.identifier
        if var breedDetail = self.dogBreedDetailsManager.dogBreedDetail(byKey: key) {
          breedDetail.confidence = result.confidence
          breedDetails.append(breedDetail)
        }
      }
      
      if breedDetails.isEmpty {
        self.postCommonError()
      } else {
        self.delegate?.dogBreedRecognizer(self, didFinishDetectBreedWithDetails: breedDetails)
      }
    }
    
    // Perform the request
    let handler = VNImageRequestHandler(ciImage: image)
    do {
      try handler.perform([request])
    } catch {
      self.postCommonError()
    }
  }
  
  // MARK: - Private
  
  private func postCommonError() {
    let error = DogBreedRecognizerError(description: "Couldn't recognize the image")
    self.delegate?.dogBreedRecognizer(self, didFinishDetectBreedWithError: error)
  }
}
