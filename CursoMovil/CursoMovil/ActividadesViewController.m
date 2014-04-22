//
//  ActividadesViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 3/28/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ActividadesViewController.h"
#import "ListaImagenesTableViewController.h"
#import "ListaVideosTableViewController.h"

@interface ActividadesViewController ()
{
	NSMutableArray *dibujos;
	NSMutableArray *videos;
}

@end

@implementation ActividadesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//Cargar informacion de servicio web de acuerdo al boton seleccionado
	if(self.source==0){			//Agua
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/agua.php"];
	}else if(self.source==1){	//Reciclaje
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/reciclaje.php"];
	}else if(self.source==2){	//Biodiversidad
		[self cargaDatosWeb:@"http://intranet.bluehats.mx/moviles/biodiversidad.php"];
	}else if(self.source==3){	//Energias
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
	
	NSDictionary *obj = @{@"nombre":[[datos objectForKey:@"dibujos"] objectForKey:@"nombre"],@"url":[[datos objectForKey:@"dibujos"] objectForKey:@"url"]};
	[dibujos addObject:obj];
	
	obj = @{@"nombre":@"Video 1",@"url":[[datos objectForKey:@"videos"] objectForKey:@"1"]};
	[videos addObject:obj];
	
	
	//NSLog(@"%@",[[datos objectForKey:@"dibujos"] objectForKey:@"nombre"]);
	//NSLog(@"%@",[[datos objectForKey:@"dibujos"] objectForKey:@"url"]);
	
	//NSLog(@"%@",[[datos objectForKey:@"videos"] objectForKey:@"1"]);
	
	
	
	
	
	//Resultados:
	//NSLog(@"dibujos: %@",dibujos);
	//NSLog(@"videos: %@",videos);
	
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
	}else if([segue.identifier isEqualToString:@"goToDibujos"]){
		ListaImagenesTableViewController *vc = [segue destinationViewController];
		vc.imagenes = dibujos;
	}else if([segue.identifier isEqualToString:@"goToConsejos"]){
		
	}
}

@end
