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

#import <UIKit/UIKit.h>

@interface CanvasViewController : UIViewController{

	CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
	
    BOOL mouseSwiped;
}

@property int source;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSString *image_url;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

@property (strong, nonatomic) UIBarButtonItem *guardarBtn;
@property (strong, nonatomic) UIBarButtonItem *shareFBBtn;
@property (strong, nonatomic) UIBarButtonItem *shareTWBtn;

//color buttons actions
- (IBAction)blueAction:(id)sender;
- (IBAction)purpleAction:(id)sender;
- (IBAction)pinkAction:(id)sender;
- (IBAction)redAction:(id)sender;
- (IBAction)orangeAction:(id)sender;
- (IBAction)yellowAction:(id)sender;
- (IBAction)greenAction:(id)sender;
- (IBAction)whiteAction:(id)sender;

@end