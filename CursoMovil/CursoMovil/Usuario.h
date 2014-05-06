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


@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSNumber * puntos;
@property (nonatomic, retain) NSNumber * medalla1;
@property (nonatomic, retain) NSNumber * medalla2;
@property (nonatomic, retain) NSNumber * medalla3;
@property (nonatomic, retain) NSNumber * medalla4;
@property (nonatomic, retain) NSNumber * trofeo;

@property (nonatomic, retain) NSNumber * mod1act1;
@property (nonatomic, retain) NSNumber * mod1act2;
@property (nonatomic, retain) NSNumber * mod1act3;
@property (nonatomic, retain) NSNumber * mod2act1;
@property (nonatomic, retain) NSNumber * mod2act2;
@property (nonatomic, retain) NSNumber * mod2act3;
@property (nonatomic, retain) NSNumber * mod3act1;
@property (nonatomic, retain) NSNumber * mod3act2;
@property (nonatomic, retain) NSNumber * mod3act3;
@property (nonatomic, retain) NSNumber * mod4act1;
@property (nonatomic, retain) NSNumber * mod4act2;
@property (nonatomic, retain) NSNumber * mod4act3;

@end
