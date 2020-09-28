

struct DateService {
    
    static let shared = DateService()
    static let myCalendar = Calendar(identifier: .gregorian)
   
    public func convertTimeStampToHour(timeStamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: Date(timeIntervalSince1970: timeStamp))
        
    }
    
    public func convertTimeStampToHourAndMinute(timeStamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: timeStamp))
        
    }
    
    public func convertedToVietnameseDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let vietnameseWeekDay = Constants.vietnameseWeekDay
        let weekday = DateService.myCalendar.component(.weekday, from: date)
        let vietnameseDate = dateFormatter.string(from: date).split(separator: "-")
        return vietnameseWeekDay[weekday - 1] + ", ngày \(String(vietnameseDate[2])) tháng \(String(vietnameseDate[1]))"
    }
    
    public func convertedToVietnameseDayDate(timeStamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date(timeIntervalSince1970: timeStamp)
        let weekday = DateService.myCalendar.component(.weekday, from: date)
        return Constants.vietnameseWeekDay[weekday - 1]
    }
}


