//
//  CombineHelpers.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 11/09/21.
//

import Combine
import UserFeature

public extension HTTPClient {
  typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
  
  func getPublisher(url: URL) -> Publisher {
    var task: HTTPClientTask?
    
    return Deferred {
      Future { completion in
        task = self.get(from: url, completion: completion)
      }
    }
    .handleEvents(receiveCancel: { task?.cancel() })
    .eraseToAnyPublisher()
  }
}

public extension UserImageDataLoader {
  typealias Publisher = AnyPublisher<Data, Error>
  
  func loadImageDataPublisher(from url: URL) -> Publisher {
    return Deferred {
      Future { completion in
        completion(Result {
          try self.loadImageData(from: url)
        })
      }
    }
    .eraseToAnyPublisher()
  }
}

extension Publisher {
  func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
    receive(on: DispatchQueue.immediateWhenOnMainQueueScheduler).eraseToAnyPublisher()
  }
}

extension DispatchQueue {
  static var immediateWhenOnMainQueueScheduler: ImmediateWhenOnMainQueueScheduler {
    ImmediateWhenOnMainQueueScheduler.shared
  }
  
  struct ImmediateWhenOnMainQueueScheduler: Scheduler {
    typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
    typealias SchedulerOptions = DispatchQueue.SchedulerOptions
    
    var now: SchedulerTimeType {
      DispatchQueue.main.now
    }
    
    var minimumTolerance: SchedulerTimeType.Stride {
      DispatchQueue.main.minimumTolerance
    }
    
    static let shared = Self()
    
    private static let key = DispatchSpecificKey<UInt8>()
    private static let value = UInt8.max
    
    private init() {
      DispatchQueue.main.setSpecific(key: Self.key, value: Self.value)
    }
    
    private func isMainQueue() -> Bool {
      DispatchQueue.getSpecific(key: Self.key) == Self.value
    }
    
    func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
      guard isMainQueue() else {
        return DispatchQueue.main.schedule(options: options, action)
      }
      
      action()
    }
    
    func schedule(after date: SchedulerTimeType, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) {
      DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
    }
    
    func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
      DispatchQueue.main.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
    }
  }
}