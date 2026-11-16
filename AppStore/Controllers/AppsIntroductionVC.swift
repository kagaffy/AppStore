//
//  AppsIntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/21.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Domain
import Foundation

class AppsIntroductionVC: IntroductionVC {
    override var charts: [RankingChart] {
        [
            .recommendedNewApps,
            .topFree,
            .ipadTopFree,
            .topSales,
            .ipadTopSales,
            .topPaid,
        ]
    }
}
