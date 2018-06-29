//
//  SettingsViewController.m
//  Flix
//
//  Created by Leah Xiao on 6/28/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "SettingsViewController.h"
# import "MoviesViewController.h"

@interface SettingsViewController ()
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *AlphaSwitch;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool isAlphaOn = [defaults boolForKey:@"isSwitchOn" ];
    self.AlphaSwitch.on = isAlphaOn;
  //  self.tableView.delegate = self;
   // self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}
- (IBAction)ifSwitchTapped:(id)sender {
    bool onSwitch = self.AlphaSwitch.isOn;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:onSwitch forKey:@"isSwitchOn"]; //uploads
    [defaults synchronize]; // saves
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.index = indexPath.row;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    <#code#>
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5; // fix
//}

@end
