//
//  MetricMaster.swift
//  Demo
//
//  Created by Jarvis on 2023/6/15.
//

import Foundation
import MetricKit

class MetricMaster: NSObject {
  
  static let shared = MetricMaster()
  private override init() {
    super.init()
  }
  
  func subscrib() {
    let metric = MXMetricManager.shared
    metric.add(self)
  }
}

extension MetricMaster: MXMetricManagerSubscriber {
  func didReceive(_ payloads: [MXMetricPayload]) {
    print("--\(#line) --> \(payloads)")
  }
  
  func didReceive(_ payloads: [MXDiagnosticPayload]) {
    print("--\(#line) --> \(payloads)")
  }
}
