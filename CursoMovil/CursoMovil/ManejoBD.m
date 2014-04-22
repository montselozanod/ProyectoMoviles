//
//  ManejoBD.m
//  CursoMovil
//
//  Created by Eliézer Galván on 4/14/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ManejoBD.h"
#import "Usuario.h"

@implementation ManejoBD

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Core Data stack

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Replace this implementation with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Modelo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Modelo.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma-mark Singleton Methods

- (id)init
{
	if(self = [super init]){
		//init stuff
	}
	
	return self;
}

+ (ManejoBD *)instancia
{
	static ManejoBD *_instancia = nil;
	static dispatch_once_t safer;
	
	dispatch_once(&safer, ^(void){
		_instancia = [[ManejoBD alloc] init];
	});
	
	return _instancia;
}

-(void)initUsuario
{
	NSManagedObjectContext *context = self.managedObjectContext;
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	NSError *error;
	NSMutableArray *results = (NSMutableArray *)[context executeFetchRequest:request error:&error];
	
	if(results.count==0){
		NSLog(@"Usuario no cargado...");
		
		NSManagedObjectContext *context = self.managedObjectContext;
		Usuario *nuevoUsuario = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
		
		//Caracteristicas iniciales del usuario
		nuevoUsuario.puntos = [NSNumber numberWithInt:0];
		nuevoUsuario.medalla1 = NO;
		nuevoUsuario.medalla2 = NO;
		nuevoUsuario.medalla3 = NO;
		nuevoUsuario.medalla4 = NO;
		nuevoUsuario.trofeo = NO;
		
		[self saveContext];
		
	}else{
		NSLog(@"Usuario existente...");
	}
}

//Getters
-(NSNumber *)getPuntos
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	return 0;
    } else {
        Usuario *u = datos[0];
        return u.puntos;
    }
}

-(BOOL)hasMedalla1Won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	return NO;
    } else {
        Usuario *u = datos[0];
        return (BOOL)u.medalla1;
    }
}

-(BOOL)hasMedalla2Won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	return NO;
    } else {
        Usuario *u = datos[0];
        return (BOOL)u.medalla2;
    }
}

-(BOOL)hasMedalla3Won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	return NO;
    } else {
        Usuario *u = datos[0];
        return (BOOL)u.medalla3;
    }
}

-(BOOL)hasMedalla4Won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	return NO;
    } else {
        Usuario *u = datos[0];
        return (BOOL)u.medalla4;
    }
}

-(BOOL)hasTrofeoWon
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	return NO;
    } else {
        Usuario *u = datos[0];
        return (BOOL)u.trofeo;
    }
}

//Setters
-(void)addPuntos:(NSNumber *)amount
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving puntos for addition");
    } else {
        Usuario *u = datos[0];
       	u.puntos = [NSNumber numberWithInt:[u.puntos intValue]+[amount intValue]];
    }
	
	[self saveContext];
}

-(void)setMedalla1Won:(BOOL)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving medalla1 for modification");
    } else {
        Usuario *u = datos[0];
       	u.medalla1 = [NSNumber numberWithBool:won];
    }
	
	[self saveContext];
}

-(void)setMedalla2Won:(BOOL)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving medalla2 for modification");
    } else {
        Usuario *u = datos[0];
       	u.medalla2 = [NSNumber numberWithBool:won];
    }
	
	[self saveContext];
}

-(void)setMedalla3Won:(BOOL)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving medalla3 for modification");
    } else {
        Usuario *u = datos[0];
       	u.medalla3 = [NSNumber numberWithBool:won];
    }
	
	[self saveContext];
}

-(void)setMedalla4Won:(BOOL)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving medalla4 for modification");
    } else {
        Usuario *u = datos[0];
       	u.medalla4 = [NSNumber numberWithBool:won];
    }
	
	[self saveContext];
}

-(void)setTrofeoWon:(BOOL)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving trofeo for modification");
    } else {
        Usuario *u = datos[0];
       	u.trofeo = [NSNumber numberWithBool:won];
    }
	
	[self saveContext];
}

@end