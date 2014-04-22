//
//  ManejoBD.h
//  CursoMovil
//
//  Created by Eliézer Galván on 4/14/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ManejoBD : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//Singleton methods

- (id)init;
+ (ManejoBD *)instancia;

-(void)initUsuario;

-(NSNumber *)getPuntos;
-(BOOL)hasMedalla1Won;
-(BOOL)hasMedalla2Won;
-(BOOL)hasMedalla3Won;
-(BOOL)hasMedalla4Won;
-(BOOL)hasTrofeoWon;

-(void)addPuntos:(NSNumber *)amount;
-(void)setMedalla1Won:(BOOL)won;
-(void)setMedalla2Won:(BOOL)won;
-(void)setMedalla3Won:(BOOL)won;
-(void)setMedalla4Won:(BOOL)won;
-(void)setTrofeoWon:(BOOL)won;

@end