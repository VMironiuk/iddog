//
//  AsyncOperation.swift
//  IDDog
//
//  Created by Vladimir Mironiuk on 16.09.2020.
//  Copyright © 2020 Vladimir Mironiuk. All rights reserved.
//

import UIKit

class AsyncOperation: Operation {
  
  // MARK: - Properties
  
  var state: State = .ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: self.state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: self.state.keyPath)
    }
  }
  
  override var isReady: Bool {
    return super.isReady && self.state == .ready
  }
  
  override var isExecuting: Bool {
    return self.state == .executing
  }
  
  override var isFinished: Bool {
    return self.state == .finished
  }
  
  override var isAsynchronous: Bool {
    return true
  }
  
  // MARK: - Lifecycle
  
  override func start() {
    self.main()
    self.state = .executing
  }
}

extension AsyncOperation {
  enum State: String {
    case ready, executing, finished
    
    fileprivate var keyPath: String {
      return "is\(self.rawValue.capitalized)"
    }
  }
}
