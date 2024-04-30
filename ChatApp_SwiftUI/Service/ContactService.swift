//
//  ContactService.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-29.
//

import Foundation
import Combine
import Contacts

enum ContactError:Error {
    case permissionDeny
}

protocol ContactServiceType {
    func fetchContact() -> AnyPublisher<[User], ServiceError>
}

class ContactService: ContactServiceType {
    func fetchContact() -> AnyPublisher<[User], ServiceError> {
        Future { [weak self] promise in
            self?.fetchContact{
                promise($0)
            }
        }
        .mapError { .error($0) }
        .eraseToAnyPublisher()
    }
    
    private func fetchContact(completion: @escaping (Result<[User], Error>) -> Void) {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { isGranted, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard isGranted else {
                completion(.failure(ContactError.permissionDeny))
                return
            }
            
            DispatchQueue.global().async { [weak self] in
                self?.fetchContact(store: store, completion: completion)
            }
        }
    }
    
    private func fetchContact(store: CNContactStore, completion: @escaping (Result<[User], Error>) -> Void) {
        let keyToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        
        let request = CNContactFetchRequest(keysToFetch: keyToFetch)
        var users: [User] = []

        do {
            try store.enumerateContacts(with: request) { contact, _ in
                let name = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
                let phoneNumber = contact.phoneNumbers.first?.value.stringValue
                let user: User = .init(id: UUID().uuidString, name: name, phoneNumber: phoneNumber)
                
                users.append(user)
            }
            completion(.success(users))
        } catch {
            completion(.failure(error))
        }
    }
    
    
}

class StubContactService: ContactServiceType {
    func fetchContact() -> AnyPublisher<[User], ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
