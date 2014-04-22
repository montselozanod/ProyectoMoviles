//
//  ActividadesViewController.h
//  CursoMovil
//
//  Created by Eliézer Galván on 3/28/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActividadesViewController : UIViewController<NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property int source;
@property(strong, nonatomic) NSURLConnection *conn;
@property(strong, nonatomic) NSMutableData *response;

@end
