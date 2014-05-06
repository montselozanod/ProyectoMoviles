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
