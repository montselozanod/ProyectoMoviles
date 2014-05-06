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

#import "ActividadesViewController.h"
#import "ListaImagenesTableViewController.h"
#import "ListaVideosTableViewController.h"
#import "ListaConsejosTableViewController.h"

@interface ActividadesViewController ()
{
	NSMutableArray *dibujos;
	NSMutableArray *videos;
	NSMutableArray *consejos;
}

@end

@implementation ActividadesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.buttonsView.alpha = 0.8;
	self.buttonsView.layer.cornerRadius = 10.0;
	
	//Cargar informacion de servicio web de acuerdo al boton seleccionado
	if(self.source==0){			//Agua
		self.navigationItem.title = @"Cuidado del Agua";
		self.imageTheme.image = [UIImage imageNamed:@"fondo_agua.jpg"];
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/agua.php"];
	}else if(self.source==1){	//Reciclaje
		self.navigationItem.title = @"Reciclaje";
		self.imageTheme.image = [UIImage imageNamed:@"fondo_reciclaje.jpg"];
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/reciclaje.php"];
	}else if(self.source==2){	//Biodiversidad
		self.navigationItem.title = @"Biodiversidad";
		self.imageTheme.image = [UIImage imageNamed:@"fondo_biodiversidad.png"];
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/biodiversidad.php"];
	}else if(self.source==3){	//Energias
		self.navigationItem.title = @"Energías Renovables";
		self.imageTheme.image = [UIImage imageNamed:@"fondo_renovables.png"];
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/energias-renovables.php"];
	}else{
		NSLog(@"menu source error");
	}
}

-(void)cargaDatosWeb:(NSString *)url
{
	NSURL *myurl = [[NSURL alloc] initWithString:url];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:myurl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
	
	self.conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.response = [[NSMutableData alloc] init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma-mark Connection control

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.response appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	int statusCode = [httpResponse statusCode];
	NSLog(@"status code: %d",statusCode);
	
	if(statusCode!=200){
		
		NSString *err = nil;
		
		switch (statusCode) {
			case 400:
				err = @"Bad Request";
				break;
				
			case 403:
				err = @"Forbidden";
				break;
				
			case 404:
				err = @"Not Found";
				break;
				
			case 408:
				err = @"Request Timeout";
				break;
				
			case 500:
				err = @"Internal Server Error";
				break;
				
			default:
				err = @"Unrecognized Error";
				break;
		}
		
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %d",httpResponse.statusCode]
														message:err
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
	}
	
	[self.response setLength:0];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSError *error;
	NSDictionary *datos = [NSJSONSerialization JSONObjectWithData:self.response options:kNilOptions error:&error];
	
	//NSLog(@"received from web: %@",datos);

	dibujos = [[NSMutableArray alloc] init];
	videos = [[NSMutableArray alloc] init];
	consejos = [[NSMutableArray alloc] init];
	
	//Fetch images
	for(NSDictionary *i in [datos objectForKey:@"dibujos"]){
		[dibujos addObject:i];
	}
	
	//Fetch videos
	for(NSDictionary *i in [datos objectForKey:@"videos"]){
		[videos addObject:i];
	}
	
	//Fetch audio
	for(NSDictionary *i in [datos objectForKey:@"consejos"]){
		[consejos addObject:i];
	}
	
	//Resultados:
	//NSLog(@"dibujos: %@",dibujos);
	//NSLog(@"videos: %@",videos);
	//NSLog(@"consejos: %@",consejos);
	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:[NSString stringWithFormat:@"%@",error.localizedDescription]
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

#pragma-mark Navigation Control

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"goToVideos"]){
		ListaVideosTableViewController *vc = [segue destinationViewController];
		vc.videos = videos;
		vc.source = self.source;
	}else if([segue.identifier isEqualToString:@"goToDibujos"]){
		ListaImagenesTableViewController *vc = [segue destinationViewController];
		vc.imagenes = dibujos;
		vc.source = self.source;
	}else if([segue.identifier isEqualToString:@"goToConsejos"]){
		ListaConsejosTableViewController *vc = [segue destinationViewController];
		vc.consejos = consejos;
		vc.source = self.source;
	}
}

@end
