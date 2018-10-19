//
//  TradeView.swift
//  Viper
//
//  Created by MBA0002 on 10/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol TradeViewDelegate: class {
  func tradeView(_ subview: TradeView, needPerform action: TradeView.Action)
}

final class TradeView: UIView {

  // MARK: - enum
  enum Action {
    case sell
    case buy
    case encourage
  }

  // MARK: - Outlets
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var winLooseTodayLabel: HighlightLabel!
  @IBOutlet weak var profitTodayLabel: HighlightLabel!
  @IBOutlet weak var currentRateLabel: UILabel!
  @IBOutlet weak var firstTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var secondTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var thirdTopConstraint: NSLayoutConstraint!

  // MARK: - Properties
  weak var delegate: TradeViewDelegate?

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  // MARK: - Private functions
  private func commonInit() {
    Bundle.main.loadNibNamed(
      R.nib.tradeView.name,
      owner: self,
      options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    // scale constraint
    firstTopConstraint.scale(by: .vertical)
    secondTopConstraint.scale(by: .vertical)
    thirdTopConstraint.scale(by: .vertical)
  }

  // MARK: - Private functions
  private func configProfitToday(value: Double) {
    let fullText = R.string.localized.profitTodayText("\(value)")
    let profitText = "\(value)"

    let attributes: [NSAttributedString.Key: Any]
    if value < 0 {
      attributes = [.foregroundColor: R.color.hightlightMinusText,
                    .font: UIFont.systemFont(ofSize: 15)]
    } else {
      attributes = [.foregroundColor: R.color.hightlightPlusText,
                    .font: UIFont.systemFont(ofSize: 15)]
    }

    profitTodayLabel.highlightAttributes = attributes
    profitTodayLabel.setFullText(fullText).setHighlighText(profitText)
  }

  // MARK: - Public functions
  func updateView(with profit: Profit) {
    configProfitToday(value: profit.value)
  }

  func updateView(with quote: Quote) {
    let roundedString = String(format: "%.3f", quote.price)
    currentRateLabel.text = roundedString
  }

  // MARK: - Actions
  @IBAction func sellButtonTouchUpInside(_ sender: Any) {
    delegate?.tradeView(self, needPerform: .sell)
  }

  @IBAction func buyButtonTouchUpInside(_ sender: Any) {
    delegate?.tradeView(self, needPerform: .buy)
  }

  @IBAction func encourageButtonTouchUpInside(_ sender: Any) {
    delegate?.tradeView(self, needPerform: .encourage)
  }
}
