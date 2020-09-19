//
//  DogBreedRecognizeOperation.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 16.09.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import UIKit
import CoreML
import Vision

class DogBreedRecognizeOperation: AsyncOperation {
  
  // MARK: - Properties
  
  var dogBreedDetails = [DogBreedDetail]()
  var image: CIImage
  
  private let dogBreedDetailsManager = DogBreedDetailsManager()
  private let minConfidence: VNConfidence = 0.01
  
  // MARK: - Lifecycle
  
  init(image: CIImage) {
    self.image = image
    super.init()
  }
  
  override func main() {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      defer { self.state = .finished }
      
      // Load the model
      guard let inceptionv3 = try? Inceptionv3(configuration: MLModelConfiguration()),
            let model = try? VNCoreMLModel(for: inceptionv3.model) else {
        print("Cannot load the model")
        return
      }

      // Make the request
      let request = VNCoreMLRequest(model: model) { (request, error) in
        if error != nil {
          print("Cannot make a request to the model: \(error!)")
          return
        }
        
        guard let results = request.results as? [VNClassificationObservation] else {
          print("Cannot take results of recognition")
          return
        }
        
        self.handleResults(results)
      }
      
      // Perform the request
      let handler = VNImageRequestHandler(ciImage: self.image)
      do {
        try handler.perform([request])
      } catch {
        print("Cannot handle the request")
      }
    }
  }
  
  // MARK: - Private
  
  private func handleResults(_ results: [VNClassificationObservation]) {
    self.dogBreedDetails.removeAll()
    
    results.forEach { result in
      let keys = result.identifier.components(separatedBy: ", ")
      keys.forEach { key in
        let key = key.lowercased()
        if K.availableDogBreeds.contains(key) && self.minConfidence < result.confidence {
          if var breedDetail = self.dogBreedDetailsManager.dogBreedDetail(forKey: String(key)) {
            breedDetail.confidence = result.confidence
            self.dogBreedDetails.append(breedDetail)
          }
        }
      }
    }
  }
}
