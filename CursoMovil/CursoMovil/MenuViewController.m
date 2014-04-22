//
//  MenuViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 3/28/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "MenuViewController.h"
#import "ActividadesViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    if([segue.identifier isEqualToString:@"goToAgua"]){
	
		ActividadesViewController *act = [segue destinationViewController];
		act.source = 0;
		
		NSLog(@"agua - 0");
		
	}else if([segue.identifier isEqualToString:@"goToRecicla"]){
		
		ActividadesViewController *act = [segue destinationViewController];
		act.source = 1;
		
		NSLog(@"recicla - 1");
		
	}else if([segue.identifier isEqualToString:@"goToBio"]){
		
		ActividadesViewController *act = [segue destinationViewController];
		act.source = 2;
		
		NSLog(@"bio - 2");
		
	}else if([segue.identifier isEqualToString:@"goToEnergia"]){
		
		ActividadesViewController *act = [segue destinationViewController];
		act.source = 3;
		
		NSLog(@"energia - 3");
		
	}
}


@end
