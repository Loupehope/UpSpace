//
//  TimeCellViewModel.swift
//  UpSpace
//
//  Created by Vlad Suhomlinov on 19.09.2019.
//  Copyright © 2019 Vlad Suhomlinov. All rights reserved.
//

import Foundation
import SwiftDate

final class TimeCellViewModel {
    private var timerUpdating: Timer?
    private var difference: TimeInterval = .zero
    var onTimeChanged: (([String]) -> Void)?

    init(time: Date) {
        difference = time.timeIntervalSince1970 - Date().timeIntervalSince1970
        self.timerUpdating = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else {
                return
            }

            guard self.difference > 0 else {
                self.timerUpdating?.invalidate()
                self.timerUpdating = nil
                return
            }
            self.difference -= 1
            let date = Date(timeIntervalSince1970: self.difference)
            self.onTimeChanged?(self.getTimeString(from: date))
        }
    }

    private func getTimeString(from date: Date) -> [String] {
        let date2 = Date(timeInterval: difference, since: Date())
        let calender = Calendar.current
        var timeComponents = [String]()
        let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date(), to: date2)

        guard let year = components.year,
              let month = components.month,
              let day = components.day,
              let hour = components.hour,
              let minute = components.minute,
              let second = components.second else {
            return []
        }

        timeComponents.append("\(year)")
        timeComponents.append("\(month)")
        timeComponents.append("\(day)")
        timeComponents.append("\(hour)")
        timeComponents.append("\(minute)")
        timeComponents.append("\(second)")
        return timeComponents
    }

    func startTime() {
        guard difference > 0 else {
            return
        }

        self.timerUpdating?.fire()
    }
}
