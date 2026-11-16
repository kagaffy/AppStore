//
//  GamesIntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/21.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import AppData
import Domain
import Foundation

class GamesIntroductionVC: IntroductionVC {
    override var accessUrls: [URL] {
        [
            URLMaker.recommendedNewGames,
            URLMaker.topFreeGames,
            URLMaker.topPaidGames,
        ]
    }
}
