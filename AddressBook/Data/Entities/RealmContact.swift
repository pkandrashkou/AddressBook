import RealmSwift

@objcMembers
final class RealmContact: Object {
    dynamic var id = UUID().uuidString

    dynamic var firstName = ""
    dynamic var lastName: String? = nil
    dynamic var email = ""
    dynamic var phoneNumber = ""
    dynamic var address: String? = nil

    override static func primaryKey() -> String? {
        return "id"
    }

    func toDomain() -> Contact {
        return Contact(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            address: address
        )
    }

    static func from(contact: NewContact) -> RealmContact {
        let realmContact = RealmContact()
        realmContact.firstName = contact.firstName
        realmContact.lastName = contact.lastName
        realmContact.email = contact.email
        realmContact.phoneNumber = contact.phoneNumber
        realmContact.address = contact.address
        return realmContact
    }
}

