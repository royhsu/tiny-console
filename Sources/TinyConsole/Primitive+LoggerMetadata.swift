//
//  Prmitive+LoggerMetadata.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import TreeCore
import Logging

extension Primitive {
  init(_ value: Logger.Metadata.Value) {
    switch value {
    case let .string(string):
      self = .string(string)
    case let .stringConvertible(convertible):
      self = .string(String(describing: convertible))
    case let .array(array):
      self = .array(array.map(Primitive.init))
    case let .dictionary(dictionary):
      self = .dictionary(
        Dictionary(
          uniqueKeysWithValues: dictionary.map { key, value in
            (Key(stringValue: key), Primitive(value))
          }
        )
      )
    }
  }
  
  init(metadata: Logger.Metadata) {
    self = .dictionary(
      Dictionary(
        uniqueKeysWithValues: metadata.map { key, value in
          (Key(stringValue: key), Primitive(value))
        }
      )
    )
  }
}
