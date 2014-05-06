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
-(NSNumber *)hasMedalla1Won;
-(NSNumber *)hasMedalla2Won;
-(NSNumber *)hasMedalla3Won;
-(NSNumber *)hasMedalla4Won;
-(NSNumber *)hasTrofeoWon;

-(void)addPuntos:(NSNumber *)amount;
-(void)setMedalla1Won:(NSNumber *)won;
-(void)setMedalla2Won:(NSNumber *)won;
-(void)setMedalla3Won:(NSNumber *)won;
-(void)setMedalla4Won:(NSNumber *)won;
-(void)setTrofeoWon:(NSNumber *)won;

//Control puntos

-(NSNumber *)hasMod1Act1;
-(NSNumber *)hasMod1Act2;
-(NSNumber *)hasMod1Act3;
-(NSNumber *)hasMod2Act1;
-(NSNumber *)hasMod2Act2;
-(NSNumber *)hasMod2Act3;
-(NSNumber *)hasMod3Act1;
-(NSNumber *)hasMod3Act2;
-(NSNumber *)hasMod3Act3;
-(NSNumber *)hasMod4Act1;
-(NSNumber *)hasMod4Act2;
-(NSNumber *)hasMod4Act3;

-(void)setMod1Act1:(NSNumber *)won;
-(void)setMod1Act2:(NSNumber *)won;
-(void)setMod1Act3:(NSNumber *)won;
-(void)setMod2Act1:(NSNumber *)won;
-(void)setMod2Act2:(NSNumber *)won;
-(void)setMod2Act3:(NSNumber *)won;
-(void)setMod3Act1:(NSNumber *)won;
-(void)setMod3Act2:(NSNumber *)won;
-(void)setMod3Act3:(NSNumber *)won;
-(void)setMod4Act1:(NSNumber *)won;
-(void)setMod4Act2:(NSNumber *)won;
-(void)setMod4Act3:(NSNumber *)won;

@end