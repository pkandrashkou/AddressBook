// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  internal enum AddContacts {
    internal enum Address {
      /// Address
      internal static let placeholder = L10n.tr("AddContacts", "address.placeholder")
    }
    internal enum CancelButton {
      /// Cancel
      internal static let title = L10n.tr("AddContacts", "cancelButton.title")
    }
    internal enum Email {
      /// Email
      internal static let placeholder = L10n.tr("AddContacts", "email.placeholder")
    }
    internal enum FirstName {
      /// First Name
      internal static let placeholder = L10n.tr("AddContacts", "firstName.placeholder")
    }
    internal enum LastName {
      /// Last Name
      internal static let placeholder = L10n.tr("AddContacts", "lastName.placeholder")
    }
    internal enum NavigationBar {
      /// New Contact
      internal static let title = L10n.tr("AddContacts", "navigationBar.title")
    }
    internal enum PhoneNumber {
      /// Phone
      internal static let placeholder = L10n.tr("AddContacts", "phoneNumber.placeholder")
    }
    internal enum SaveButton {
      /// Save
      internal static let title = L10n.tr("AddContacts", "saveButton.title")
    }
  }
  internal enum ContactsList {
    internal enum EmptyList {
      internal enum MainLabel {
        /// No Contacts
        internal static let text = L10n.tr("ContactsList", "emptyList.mainLabel.text")
      }
      internal enum SubLabel {
        /// Use the '+' Icon to add a new contact
        internal static let text = L10n.tr("ContactsList", "emptyList.subLabel.text")
      }
    }
    internal enum NavigationBar {
      /// Contacts
      internal static let title = L10n.tr("ContactsList", "navigationBar.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
