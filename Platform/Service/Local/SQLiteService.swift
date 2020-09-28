

final class SQLiteService {
    static let shared = SQLiteService()
    var databasePath: String?
    
    init() {
        databasePath = copyDatabaseIfNeeded()
    }

    func copyDatabaseIfNeeded() -> String? {
        let fileManager = FileManager.default
        let documentUrl = fileManager.urls(for: .documentDirectory, in: .allDomainsMask)
        guard documentUrl.count != 0 else {
            return nil
        }
        let finalDatabaseURL = documentUrl.first!.appendingPathComponent(Constants.dbPath)
        if !((try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("Not exist!")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(Constants.dbPath)
            print("FROM",documentsURL?.path)
            print("TO",finalDatabaseURL.path)
            do {
                print(documentsURL?.path)
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
                return finalDatabaseURL.path
            } catch {
                print(error.localizedDescription)
                print("Cant copy")
            }
        }
        else {
            print("Duong dan: \(finalDatabaseURL.path)")
            return finalDatabaseURL.path
        }
        return nil
    }
    
    
}
