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

#import "MedallasViewController.h"
#import "ManejoBD.h"

@interface MedallasViewController ()
{
	ManejoBD *bd;
}

@end

@implementation MedallasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	bd = [[ManejoBD alloc] init];
	[bd initUsuario];
	
	self.puntos.text = [NSString stringWithFormat:@"%@ puntos",[bd getPuntos]];

	NSLog(@"med1: %@",[bd hasMedalla1Won]);
	NSLog(@"med2: %@",[bd hasMedalla2Won]);
	NSLog(@"med3: %@",[bd hasMedalla3Won]);
	NSLog(@"med4: %@",[bd hasMedalla4Won]);
	NSLog(@"trof: %@",[bd hasTrofeoWon]);
	
	//Check medals won
	if([bd hasMod1Act1]==[NSNumber numberWithInt:1] && [bd hasMod1Act2]==[NSNumber numberWithInt:1] && [bd hasMod1Act3]==[NSNumber numberWithInt:1]){
		[bd setMedalla1Won:[NSNumber numberWithInt:1]];
		//[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado la medalla de Energías Renovables!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
	if([bd hasMod2Act1]==[NSNumber numberWithInt:1] && [bd hasMod2Act2]==[NSNumber numberWithInt:1] && [bd hasMod2Act3]==[NSNumber numberWithInt:1]){
		[bd setMedalla2Won:[NSNumber numberWithInt:1]];
		//[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado la medalla de Reciclaje!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
	if([bd hasMod3Act1]==[NSNumber numberWithInt:1] && [bd hasMod3Act2]==[NSNumber numberWithInt:1] && [bd hasMod3Act3]==[NSNumber numberWithInt:1]){
		[bd setMedalla3Won:[NSNumber numberWithInt:1]];
		//[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado la medalla de Biodiversidad!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
	if([bd hasMod4Act1]==[NSNumber numberWithInt:1] && [bd hasMod4Act2]==[NSNumber numberWithInt:1] && [bd hasMod4Act3]==[NSNumber numberWithInt:1]){
		[bd setMedalla4Won:[NSNumber numberWithInt:1]];
		//[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado la medalla de Cuidado del Agua!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
	
	if([bd hasMedalla1Won]==[NSNumber numberWithInt:1] && [bd hasMedalla2Won]==[NSNumber numberWithInt:1] && [bd hasMedalla3Won]==[NSNumber numberWithInt:1]&& [bd hasMedalla4Won]==[NSNumber numberWithInt:1]){
		[bd setTrofeoWon:[NSNumber numberWithInt:1]];
		//[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado el Trofeo Ambientalista!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
	
	//Format each medal
	if([bd hasMedalla1Won]==[NSNumber numberWithInt:1]){
		self.medallaRenovables.alpha = 1.0;
	}else{
		self.medallaRenovables.alpha = 0.4;
	}
	
	if([bd hasMedalla2Won]==[NSNumber numberWithInt:1]){
		self.medallaReciclaje.alpha = 1.0;
	}else{
		self.medallaReciclaje.alpha = 0.4;
	}
	
	if([bd hasMedalla3Won]==[NSNumber numberWithInt:1]){
		self.medallaBiodiversidad.alpha = 1.0;
	}else{
		self.medallaBiodiversidad.alpha = 0.4;
	}
	
	if([bd hasMedalla4Won]==[NSNumber numberWithInt:1]){
		self.medallaAgua.alpha = 1.0;
	}else{
		self.medallaAgua.alpha = 0.4;
	}
	
	if([bd hasTrofeoWon]==[NSNumber numberWithInt:1]){
		self.trofeo.alpha = 1.0;
	}else{
		self.trofeo.alpha = 0.4;
	}
	
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

- (IBAction)clickedRenovables:(id)sender
{
	if([bd hasMedalla1Won]==[NSNumber numberWithInt:1]){
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Energías Renovables" message:@"Felicidades! Has ganado esta medalla." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}else{
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Energías Renovables" message:@"Completa el módulo de Energías Renovables para ganar esta medalla!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}

- (IBAction)clickedReciclaje:(id)sender
{

	if([bd hasMedalla2Won]==[NSNumber numberWithInt:1]){
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Reciclaje" message:@"Felicidades! Has ganado esta medalla." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}else{
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Reciclaje" message:@"Completa el módulo de Reciclaje para ganar esta medalla!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}

- (IBAction)clickedBiodiversidad:(id)sender
{
	if([bd hasMedalla3Won]==[NSNumber numberWithInt:1]){
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Biodiversidad" message:@"Felicidades! Has ganado esta medalla." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}else{
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Biodiversidad" message:@"Completa el módulo de Biodiversidad para ganar esta medalla!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}

- (IBAction)clickedAgua:(id)sender
{
	
	if([bd hasMedalla4Won]==[NSNumber numberWithInt:1]){
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Cuidado del Agua" message:@"Felicidades! Has ganado esta medalla." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}else{
		[[[UIAlertView alloc] initWithTitle:@"Medalla de Cuidado del Agua" message:@"Completa el módulo de Cuidado del Agua para ganar esta medalla!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}

- (IBAction)clickedTrofeo:(id)sender
{
	
	if([bd hasTrofeoWon]==[NSNumber numberWithInt:1]){
		[[[UIAlertView alloc] initWithTitle:@"Trofeo Ambientalista" message:@"Felicidades! Has completado todos los módulos." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}else{
		[[[UIAlertView alloc] initWithTitle:@"Trofeo Ambientalista" message:@"Completa todos los módulos para ganar el Trofeo Ambientalista!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}
@end
