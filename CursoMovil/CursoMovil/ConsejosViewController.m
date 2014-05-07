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

#import "ConsejosViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ManejoBD.h"

@interface ConsejosViewController ()

@end

@implementation ConsejosViewController
{
	AVAudioPlayer *audioPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.textoConsejo.text = [self.consejo objectForKey:@"texto"];
	
	//Play audio from url (async download)
	dispatch_async(dispatch_get_global_queue(0,0), ^{
		NSURL *url = [NSURL URLWithString:[self.consejo objectForKey:@"url"]];
		NSData *data = [NSData dataWithContentsOfURL:url];
		if ( data == nil )
			return;
		dispatch_async(dispatch_get_main_queue(), ^{
			audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
			[audioPlayer play];
		});
	});
}

-(void)viewDidDisappear:(BOOL)animated
{
    ManejoBD *bd = [ManejoBD instancia];
	[bd initUsuario];

	//Point test for act 2
	if(self.source==0){//agua
		if([bd hasMod4Act2]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:50]];
			[bd setMod4Act2:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 50 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==1){//reciclaje
		if([bd hasMod2Act2]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:50]];
			[bd setMod2Act2:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 50 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==2){//biodiversidad
		if([bd hasMod3Act2]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:50]];
			[bd setMod3Act2:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 50 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==3){//renovables
		if([bd hasMod1Act2]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:50]];
			[bd setMod1Act2:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 50 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
