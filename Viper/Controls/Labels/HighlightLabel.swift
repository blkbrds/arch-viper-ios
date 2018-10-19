//
//  NSAttributedString.swift
//  Viper
//
//  Created by MBA0002 on 10/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HighlightLabel: UILabel {

  var highlightAttributes = [NSAttributedString.Key: Any]()

  @discardableResult
  func setFullText(_ text: String?) -> Self {
    self.text = text
    return self
  }

  @discardableResult
  func setHighlighText(_ text: String?) -> Self {
    guard let text = text else { return self }
    attributedText = attributedText?.applying(attributes: highlightAttributes, toRangesMatching: text)
    return self
  }

}
