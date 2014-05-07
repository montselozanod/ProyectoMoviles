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

#import "VideosViewController.h"
#import "ManejoBD.h"
#import "AppDelegate.h"

@interface VideosViewController ()

@end

@implementation VideosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//Turn off background music
	AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
	[appDelegate.audioPlayer stop];

	[self.webView setAllowsInlineMediaPlayback:YES];
	
    [self.webView setMediaPlaybackRequiresUserAction:NO];
	
    NSString* embedHTML = [NSString stringWithFormat:@"<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>\function onYouTubeIframeAPIReady()\{ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}\function onPlayerReady(a)\{ \a.target.playVideo(); }</script><iframe id='playerId' type='text/html' width='%f' height='%f' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>",self.webView.frame.size.width,self.webView.frame.size.height,self.url];
						   
	[self.webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    ManejoBD *bd = [ManejoBD instancia];
	[bd initUsuario];

	//Point test for act 1
	if(self.source==0){//agua
		if([bd hasMod4Act1]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod4Act1:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==1){//reciclaje
		if([bd hasMod2Act1]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod2Act1:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==2){//biodiversidad
		if([bd hasMod3Act1]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod3Act1:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==3){//renovables
		if([bd hasMod1Act1]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod1Act1:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}
    
	//Turn on background music
	AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
	[appDelegate.audioPlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
