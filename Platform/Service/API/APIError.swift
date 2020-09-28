

struct APIResponseError: APIError {
    let statusCode: Int?
    let statusMessage: String
    
    var errorDescription: String? {
        return statusMessage
    }
}

