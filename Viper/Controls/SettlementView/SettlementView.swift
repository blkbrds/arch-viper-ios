//
//  SettlementView.swift
//  Viper
//
//  Created by MBA0219 on 10/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class SettlementView: UIView {

  // MARK: - IBOutlets
  @IBOutlet private var contentView: UIView!
  @IBOutlet private weak var diferenceTopConstraint: NSLayoutConstraint!
  @IBOutlet private weak var differenceBottomConstraint: NSLayoutConstraint!

  // MARK: - Properties
  var action: TradeAction

  // MARK: - Init
  init(frame: CGRect, action: TradeAction) {
    self.action = action
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    self.action = .buy
    super.init(coder: aDecoder)
    commonInit()
  }

  // MARK: - Private functions
  private func commonInit() {
    Bundle.main.loadNibNamed(
      R.nib.settlementView.name,
      owner: self,
      options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    diferenceTopConstraint.scale(by: .vertical)
    differenceBottomConstraint.scale(by: .vertical)
  }

}
