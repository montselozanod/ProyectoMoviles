//
//  MedallasViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 3/28/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "MedallasViewController.h"
#import "ManejoBD.h"

@interface MedallasViewController ()

@end

@implementation MedallasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	ManejoBD *bd = [[ManejoBD alloc] init];
	[bd initUsuario];
	
	self.puntos.text = [NSString stringWithFormat:@"%@ puntos",[bd getPuntos]];
	
	NSLog(@"puntos: %@",[bd getPuntos]);
	NSLog(@"med1: %hhd",(BOOL)[bd hasMedalla1Won]);
	NSLog(@"med2: %hhd",(BOOL)[bd hasMedalla2Won]);
	NSLog(@"med3: %hhd",(BOOL)[bd hasMedalla3Won]);
	NSLog(@"med4: %hhd",(BOOL)[bd hasMedalla4Won]);
	NSLog(@"trof: %hhd",(BOOL)[bd hasTrofeoWon]);
	
	[bd addPuntos:[NSNumber numberWithInt:105]];
	[bd setMedalla1Won:YES];
	[bd setMedalla2Won:YES];
	[bd setMedalla3Won:YES];
	[bd setMedalla4Won:YES];
	[bd setTrofeoWon:YES];
	
	NSLog(@"new...");
	
	NSLog(@"puntos: %@",[bd getPuntos]);
	NSLog(@"med1: %hhd",(BOOL)[bd hasMedalla1Won]);
	NSLog(@"med2: %hhd",(BOOL)[bd hasMedalla2Won]);
	NSLog(@"med3: %hhd",(BOOL)[bd hasMedalla3Won]);
	NSLog(@"med4: %hhd",(BOOL)[bd hasMedalla4Won]);
	NSLog(@"trof: %hhd",(BOOL)[bd hasTrofeoWon]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cerrarAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
