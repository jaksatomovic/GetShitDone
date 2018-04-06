//
//  CalendarController.swift
//  GetSh*tDone
//
//  Created by Jaksa Tomovic on 06/04/2018.
//  Copyright © 2018 Jakša Tomović. All rights reserved.
//

import UIKit
import CVCalendar
import UICountingLabel
import AHKActionSheet

class CalendarController: UIViewController {
    
    var calendarMenu: CVCalendarMenuView = {
        let view = CVCalendarMenuView()
        view.backgroundColor = .black
        view.dayOfWeekFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 6))
        view.dayOfWeekTextColor = .white
        return view
    }()
    var calendarContent: CVCalendarView = {
        let view = CVCalendarView()
        view.backgroundColor = .black
        view.tintColor = .white
        return view
    }()
    
    var percentageLabel: UICountingLabel = {
        let label = UICountingLabel()
        label.text = "50"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 16))
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.sizeToFit()
        label.text = "CALENDAR"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 12))
        return label
    }()
    
    var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 1
        label.sizeToFit()
        label.text = "NOVEMBER"
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 16))
        return label
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        Globals.showPopTipOnceForKey("SHARE_HINT", userDefaults: userDefaults,
        //                                     popTipText: NSLocalizedString("share poptip", comment: ""),
        //                                     inView: view,
        //                                     fromFrame: CGRect(x: view.frame.size.width - 28, y: -10, width: 1, height: 1))
        
        //        updateStats()
        percentageLabel.text = "6 SHITS TODO"
        calendarContent.contentController.refreshPresentedMonth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        percentageLabel.animationDuration = 1.5
        percentageLabel.format = "%d%%";
        
        setupCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateCalendarView()
    }
    
    fileprivate func updateCalendarView() {
        calendarMenu.commitMenuViewUpdate()
        calendarContent.commitCalendarViewUpdate()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        view.addSubview(percentageLabel)
        view.addSubview(calendarContent)
        view.addSubview(calendarMenu)
        view.addSubview(monthLabel)
        view.addSubview(titleLabel)


        titleLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: monthLabel.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 30)
        
        monthLabel.anchor(titleLabel.bottomAnchor, left: view.leftAnchor, bottom: calendarMenu.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 40)
        
        calendarMenu.anchor(monthLabel.bottomAnchor, left: view.leftAnchor, bottom: calendarContent.topAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 30)
        calendarContent.anchor(calendarMenu.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height/2)
        
        percentageLabel.anchor(calendarContent.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
                
    }
    
    
}


extension CalendarController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate {
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        guard let date = dayView.date.convertedDate() else {
            return
        }
        percentageLabel.text = "56.0"
    }
    
    func latestSelectableDate() -> Date {
        return Date()
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        guard let percentage = percentage(for: dayView.date.convertedDate()) else { return false }
        
        return percentage > 0.0
    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        guard let percentage = percentage(for: dayView.date.convertedDate()) else { return [] }
        
        return percentage >= 1.0 ? [UIColor.white] : [UIColor.red]
    }
    
    fileprivate func percentage(for date: Date?) -> Double? {
//        guard let date = date,
//            let entry = CoreDataManager.shared.entryForDate(date) else {
//                return nil
//        }
//        print("\(entry.percentage / 100.0)")
//        return Double(entry.percentage / 100.0)
        return 56.0
    }
    
    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.white
    }
    
    func dayLabelPresentWeekdayTextColor() -> UIColor {
        return UIColor.white
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        print(date.globalDescription)
        monthLabel.text = date.globalDescription
    }
}

extension CalendarController {
    func setupCalendar() {
        calendarMenu.menuViewDelegate = self
        calendarContent.calendarDelegate = self
        calendarContent.calendarAppearanceDelegate = self
        
        //        monthLabel.text = CVDate(date: Date()).globalDescription
        //        if let font = UIFont(name: "KaushanScript-Regular", size: 16) {
        //            monthLabel.font = font
        //            monthLabel.textAlignment = .center
        //            monthLabel.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        //        }
    }
    
    //    func updateStats() {
    //        daysCountLabel.countFromZero(to: CGFloat(EntryHandler.sharedHandler.daysTracked()))
    //        quantityLabel.countFromZero(to: CGFloat(EntryHandler.sharedHandler.overallQuantity()))
    //        measureLabel.text = String(format: NSLocalizedString("unit format", comment: ""), unitName())
    //    }
    
//    func unitName() -> String {
//        if let unit = Constants.UnitsOfMeasure(rawValue: userDefaults.integer(forKey: Constants.General.unitOfMeasure.key())) {
//            return unit.nameForUnitOfMeasure()
//        }
//        return ""
//    }
//
//    func dateLabelString(_ date: Date = Date()) -> String {
//        print(date)
//        if let entry = CoreDataManager.shared.entryForDate(date) {
//            if (entry.percentage >= 100) {
//                return NSLocalizedString("goal met", comment: "")
//            } else {
//                return entry.formattedPercentage()
//            }
//        } else {
//            return ""
//        }
//    }
}
