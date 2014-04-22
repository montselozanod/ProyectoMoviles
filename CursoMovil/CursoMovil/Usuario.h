//
//  Usuario.h
//  CursoMovil
//
//  Created by Eliézer Galván on 4/14/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSNumber * puntos;
@property (nonatomic, retain) NSNumber * medalla1;
@property (nonatomic, retain) NSNumber * medalla2;
@property (nonatomic, retain) NSNumber * medalla3;
@property (nonatomic, retain) NSNumber * medalla4;
@property (nonatomic, retain) NSNumber * trofeo;

@end
