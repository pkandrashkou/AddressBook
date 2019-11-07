import Foundation

protocol EmailValidationUseCase {
    func validate(email: String) -> Bool
}

final class EmailValidationUseCaseImpl: EmailValidationUseCase {
    func validate(email: String) -> Bool {
        let trimmedText = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        let entireRange = NSRange(location: 0, length: trimmedText.count)
        let matches = detector.matches(in: trimmedText, options: [], range: entireRange)

        guard
            matches.count == 1,
            let result = matches.first else {
                return false
        }
        guard result.resultType == NSTextCheckingResult.CheckingType.link else { return false }
        guard result.url?.scheme == "mailto" else { return false }
        guard result.range == entireRange else { return false }
        guard !trimmedText.hasPrefix("mailto") else { return false }

        return true
    }
}
