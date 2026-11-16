//
//  ReviewAuxiliaryView.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/27.
//

import Domain
import UIKit

class ReviewAuxiliaryView: UIView {
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var reviewAmountLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    func loadNib() {
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            addSubview(view)
        }
    }

    func apply(appDetails: AppDetails?) {
        guard let appDetails else { return }

        averageRatingLabel.text = String(appDetails.averageUserRating)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedCounter = formatter.string(from: appDetails.userRatingCount as NSNumber)
        reviewAmountLabel.text = "\(String(formattedCounter ?? "0"))件の評価"
    }
}
