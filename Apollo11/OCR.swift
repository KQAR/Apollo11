//
//  OCR.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/30.
//

import UIKit
import Vision
import VisionKit

struct OCR {
  
  static func scanText(from image: UIImage) async throws -> String? {
    try await withCheckedThrowingContinuation { continuation in
      let request = VNRecognizeTextRequest { request, error in
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
          continuation.resume(returning: "")
          print("无法识别文字")
          return
        }
        
        var recognizedText = ""
        for observation in observations {
          guard let topCandidate = observation.topCandidates(1).first else {
            continue
          }
          recognizedText += topCandidate.string + "\n"
        }
        
        // 打印提取的文字结果
        print("提取的文字：\n\(recognizedText)")
        continuation.resume(returning: recognizedText)
      }
      
      // 创建请求处理队列
      let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
      
      // 提交图像请求
      do {
        try requestHandler.perform([request])
      } catch {
        print("图像请求处理错误: \(error.localizedDescription)")
        continuation.resume(throwing: error)
      }
    }
  }
  
  static func vision(from image: UIImage) async throws -> ImageAnalysis {
    return try await ImageAnalyzer().analyze(image, configuration: ImageAnalyzer.Configuration(.text))
  }
}
