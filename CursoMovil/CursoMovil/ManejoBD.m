//
//APRENDIZAJE VERDE - CUIDANDO EL AMBIENTE
//Mobile Development Course Project
//
//Copyright (C) 2014 - ITESM
//
//This program is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//Authors:
//
//ITESM representatives
//Ing. Martha Sordia Salinas <msordia@itesm.mx>
//Dr. Juan Arturo Nolazco Flores <jnolazco@itesm.mx>
//Ing. Maria Isabel Cabrera Cancino <marisa.cabrera@tecvirtual.mx>
//
//
//ITESM students (developers)
//Eliezer Galvan <a01190876@itesm.mx>
//Montserrat Lozano <a01088686@itesm.mx>
//Adrian Rangel <a01190871@itesm.mx>

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
		
		nuevoUsuario.medalla1 = [NSNumber numberWithInt:0];
		nuevoUsuario.medalla2 = [NSNumber numberWithInt:0];
		nuevoUsuario.medalla3 = [NSNumber numberWithInt:0];
		nuevoUsuario.medalla4 = [NSNumber numberWithInt:0];
		nuevoUsuario.trofeo = [NSNumber numberWithInt:0];
		
		nuevoUsuario.mod1act1 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod1act2 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod1act3 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod2act1 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod2act2 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod2act3 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod3act1 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod3act2 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod3act3 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod4act1 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod4act2 = [NSNumber numberWithInt:0];
		nuevoUsuario.mod4act3 = [NSNumber numberWithInt:0];
		
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

-(NSNumber *)hasMedalla1Won
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
        return u.medalla1;
    }
}

-(NSNumber *)hasMedalla2Won
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
        return u.medalla2;
    }
}

-(NSNumber *)hasMedalla3Won
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
        return u.medalla3;
    }
}

-(NSNumber *)hasMedalla4Won
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
        return u.medalla4;
    }
}

-(NSNumber *)hasTrofeoWon
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
        return u.trofeo;
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

-(void)setMedalla1Won:(NSNumber *)won
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
       	u.medalla1 = won;
    }
	
	[self saveContext];
}

-(void)setMedalla2Won:(NSNumber *)won
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
       	u.medalla2 = won;
    }
	
	[self saveContext];
}

-(void)setMedalla3Won:(NSNumber *)won
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
       	u.medalla3 = won;
    }
	
	[self saveContext];
}

-(void)setMedalla4Won:(NSNumber *)won
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
       	u.medalla4 = won;
    }
	
	[self saveContext];
}

-(void)setTrofeoWon:(NSNumber *)won
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
       	u.trofeo = won;
    }
	
	[self saveContext];
}

//Control puntos

-(NSNumber *)hasMod1Act1
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
        return u.mod1act1;
    }
}

-(NSNumber *)hasMod1Act2
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
        return u.mod1act2;
    }
}

-(NSNumber *)hasMod1Act3
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
        return u.mod1act3;
    }
}

-(NSNumber *)hasMod2Act1
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
        return u.mod2act1;
    }
}

-(NSNumber *)hasMod2Act2
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
        return u.mod2act2;
    }
}

-(NSNumber *)hasMod2Act3
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
        return u.mod2act3;
    }
}

-(NSNumber *)hasMod3Act1
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
        return u.mod3act1;
    }
}

-(NSNumber *)hasMod3Act2
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
        return u.mod3act2;
    }
}

-(NSNumber *)hasMod3Act3
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
        return u.mod3act3;
    }
}

-(NSNumber *)hasMod4Act1
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
        return u.mod4act1;
    }
}

-(NSNumber *)hasMod4Act2
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
        return u.mod4act2;
    }
}

-(NSNumber *)hasMod4Act3
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
        return u.mod4act3;
    }
}

-(void)setMod1Act1:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod1act1 = won;
    }
	
	[self saveContext];
}

-(void)setMod1Act2:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod1act2 = won;
    }
	
	[self saveContext];
}

-(void)setMod1Act3:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod1act3 = won;
    }
	
	[self saveContext];
}

-(void)setMod2Act1:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod2act1 = won;
    }
	
	[self saveContext];
}

-(void)setMod2Act2:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod2act2 = won;
    }
	
	[self saveContext];
}

-(void)setMod2Act3:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod2act3 = won;
    }
	
	[self saveContext];
}

-(void)setMod3Act1:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod3act1 = won;
    }
	
	[self saveContext];
}

-(void)setMod3Act2:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod3act2 = won;
    }
	
	[self saveContext];
}

-(void)setMod3Act3:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod3act3 = won;
    }
	
	[self saveContext];
}

-(void)setMod4Act1:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod4act1 = won;
    }
	
	[self saveContext];
}

-(void)setMod4Act2:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod4act2 = won;
    }
	
	[self saveContext];
}

-(void)setMod4Act3:(NSNumber *)won
{
	NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *datos = [context executeFetchRequest:request error:&error];
    
    if ([datos count] == 0) {
       	NSLog(@"error retreiving point control for modification");
    } else {
        Usuario *u = datos[0];
       	u.mod4act3 = won;
    }
	
	[self saveContext];
}

@end