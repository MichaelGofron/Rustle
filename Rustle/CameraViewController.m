//
//  ViewController.m
//  Rustle
//
//  Created by Mike on 11/22/14.
//  Copyright (c) 2014 GOF Enterprises. All rights reserved.
//

#import "CameraViewController.h"
#import "CustomImagePickerController.h"
#import "RustlesTableViewController.h"

@interface CameraViewController ()
@property CustomImagePickerController *PickerController;
@property CGFloat HeightOfButtons;
@property CGFloat CenterConst;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)createCustomOverlayView{
    
    // Main overlay view created
    UIView *main_overlay_view = [[UIView alloc] initWithFrame:self.view.bounds];
    
    // Clear view (live camera feed) created and added to main overlay view
    UIView *clear_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.HeightOfButtons)];
    clear_view.opaque = NO;
    clear_view.backgroundColor = [UIColor clearColor];
    [main_overlay_view addSubview:clear_view];
    
    // Set up Camera Button
    self.HeightOfButtons = 40;
       CGFloat cameraWidth = self.view.frame.size.width/4;
    CGFloat cameraX = self.view.frame.size.width/2 - cameraWidth/2;
    CGFloat cameraY = self.view.frame.size.height-self.HeightOfButtons;
    
    // Adding Camera Button
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // when a button is touched, CustomImagePickerController snaps a picture
    [cameraButton addTarget:self action:@selector(shootPicture) forControlEvents:UIControlEventTouchUpInside];
    cameraButton.frame = CGRectMake(cameraX, cameraY, cameraWidth, self.HeightOfButtons);
        //button.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height - self.HeightOfButtons, self.view.frame.size.width / 4, self.HeightOfButtons);
    [cameraButton setBackgroundColor:[UIColor redColor]];
    [main_overlay_view addSubview:cameraButton];
    
    // Setup table Button
    CGFloat tableX = 0;
    CGFloat tableY = self.view.frame.size.height-self.HeightOfButtons;
    
    // Adding Table Button
    UIButton *tableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tableButton addTarget:self action:@selector(segueToRustlesTableViewController) forControlEvents:UIControlEventTouchUpInside];
    tableButton.frame = CGRectMake(tableX, tableY, cameraWidth, self.HeightOfButtons);
    [tableButton setBackgroundColor:[UIColor blueColor]];// Use BackgroundImage later
    [main_overlay_view addSubview:tableButton];
    
    
    return main_overlay_view;
}

-(void)segueToRustlesTableViewController{
    
    RustlesTableViewController* rustlesVC = [[RustlesTableViewController alloc]init];
    [self.PickerController presentViewController:rustlesVC animated:NO completion:nil];
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //RustlesTableViewController *rustlesVC = (RustlesTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RustlesTableViewController"];
    //[self performSegueWithIdentifier:@"tableSegue" sender:self];
    //[self.PickerController presentViewController:rustlesVC animated:NO completion:nil];
    
}

- (void)makeCustomCameraAppear
{
    self.PickerController = [[CustomImagePickerController alloc] init];
    self.PickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.PickerController.showsCameraControls = NO;
    self.PickerController.delegate = self;
    
    UIView *overlay_view = [self createCustomOverlayView];
    [self.PickerController setCameraOverlayView:overlay_view];
    
    [self presentViewController:self.PickerController animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    // Now do something with pickedImage
    UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
}

- (void)viewDidAppear:(BOOL)animated
{
    [self makeCustomCameraAppear];
}

-(void)shootPicture{
    [self.PickerController takePicture];
}

@end
