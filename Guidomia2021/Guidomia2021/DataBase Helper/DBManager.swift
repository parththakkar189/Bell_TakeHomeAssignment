//
//  DBManager.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation
import CoreData

class DBManager {
    static let manager = DBManager()
    //MARK: ManagedObjectContext
    lazy var managedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    //MARK: PersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: ApplicationDocumentDirectory
    private lazy var applicationDocumentDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls.count - 1)
        return urls[urls.count - 1]
    }()
    
    //MARK: ApplicationLibraryDirectory
    private func applicationLibraryDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    //MARK: Prepare Object
    func prepare(dataForSaving: [CarsList]) {
        _ = dataForSaving.map({ [weak self] item in
            self?.createEntityFrom(carDetail: item)
        })
        saveContext()
    }
    
    
    //MARK: Create CoreData Object
    private func createEntityFrom(carDetail: CarsList) -> Vehicle {
        var toBeAddedVehicle: Vehicle = Vehicle()
        do {
            let context = self.managedObjectContext
            let request : NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
            request.predicate = NSPredicate(format: "model == %@", carDetail.model)
            let numberOfRecords = try context.count(for: request)
            if numberOfRecords == 0 {
                let vehicle = Vehicle(context: self.managedObjectContext)
                vehicle.consList = carDetail.consList
                vehicle.prosList = carDetail.prosList
                vehicle.rating = Int64(carDetail.rating)
                vehicle.make = carDetail.make
                vehicle.model = carDetail.model
                vehicle.customerPrice = carDetail.customerPrice
                vehicle.marketPrice = carDetail.marketPrice
                toBeAddedVehicle = vehicle
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        return toBeAddedVehicle
    }
    
    
    // MARK: - Core Data Saving support
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
