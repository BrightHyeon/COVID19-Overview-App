//
//  CityCovidOverView.swift
//  COVID19
//
//  Created by HyeonSoo Kim on 2022/01/05.
//

import Foundation

struct CityCovidOverview: Codable {
  let korea: CovidOverview
  let seoul: CovidOverview
  let busan: CovidOverview
  let daegu: CovidOverview
  let incheon: CovidOverview
  let gwangju: CovidOverview
  let daejeon: CovidOverview
  let ulsan: CovidOverview
  let sejong: CovidOverview
  let gyeonggi: CovidOverview
  let chungbuk: CovidOverview
  let chungnam: CovidOverview
  let jeonbuk: CovidOverview
  let jeonnam: CovidOverview
  let gyeongbuk: CovidOverview
  let gyeongnam: CovidOverview
  let jeju: CovidOverview
}

struct CovidOverview: Codable {
    let countryName: String
    let newCase: String
    let totalCase: String
    let recovered: String
    let death: String
    let percentage: String
    let newCcase: String
    let newFcase: String
}
