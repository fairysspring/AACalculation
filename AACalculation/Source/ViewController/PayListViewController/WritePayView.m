//
//  WritePayView.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "WritePayView.h"
#import "PersonsViewController.h"
#import "PayModel.h"

@interface WritePayView()
@property(nonatomic, strong)NSNumber *sid;
@property(nonatomic, strong)PayModel *payModel;
@end
@implementation WritePayView

+(WritePayView *)writePayViewWithSid:(NSNumber *)sid{
    WritePayView *view = [[[NSBundle mainBundle] loadNibNamed:@"WritePayView" owner:self options:nil]objectAtIndex:0];
    view.backgroundColor = [UIColor purpleColor];
    view.width = AAScreenWidth;
    view.height = 226;
    view.top = 100;
    view.sid = sid;
    return view;
}

- (IBAction)tapPayPersonButton:(UIButton *)sender {
    if(self.containerViewController){
         PersonsViewController *vc = [[PersonsViewController alloc] initWithActivitySid:self.sid];
        vc.payPersonSid = self.payModel.payPersonSid;
        vc.showStyle = PersonsViewShowStyleSelectedPayPerson;
        WS();
        vc.selectedPayPersonsFinish = ^(NSNumber *paySid, NSString *name){
            weakself.payModel.payPersonSid = paySid;
            weakself.payModel.payPersonName = name;
            weakself.payPersonButton.titleLabel.text = weakself.payModel.payPersonSid.stringValue;
            [weakself.containerViewController.navigationController popViewControllerAnimated:YES];
        };
        [self.containerViewController.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)tapReferPersonsButton:(UIButton *)sender {
    if(self.containerViewController){
        PersonsViewController *vc = [[PersonsViewController alloc] initWithActivitySid:self.sid];
        vc.showStyle = PersonsViewShowStyleSelectedReferPersons;
        WS();
        vc.selectedReferPersonsFinish = ^(NSArray *persons){
            weakself.payModel.referPersonsSid = [persons componentsJoinedByString:@","];
            weakself.referPersonsButton.titleLabel.text = weakself.payModel.referPersonsSid;
            [weakself.containerViewController.navigationController popViewControllerAnimated:YES];
        };
        vc.selectedSidArray = [self.payModel referPersonsSidArray];
        [self.containerViewController.navigationController pushViewController:vc animated:YES];
        
    }
}

- (IBAction)tapCloseButton:(UIButton *)sender {
    [self removeFromSuperview];
}
-(PayModel *)payModel{
    if (!_payModel) {
        _payModel = [[PayModel alloc] init];
    }
    return _payModel;
}
/*
 @property(nonatomic, strong)NSNumber *sid;
 @property(nonatomic, strong)NSString *name;
 @property(nonatomic, strong)NSNumber *money;
 @property(nonatomic, strong)NSNumber *payPersonSid;
 @property(nonatomic, strong)NSString *payPersonName;
 @property(nonatomic, strong)NSNumber *time;
 @property(nonatomic, strong)NSString *referPersonsSid;
 */
- (IBAction)tapSubmitButton:(id)sender {
    self.payModel.name = self.nameTextField.text;
    self.payModel.money = @(self.moneyTextField.text.integerValue);
    
    if ([self isEmptyString:self.nameTextField.text] ||
        [self isEmptyString:self.moneyTextField.text]
         ) {
        return;
        
    }
    if ( self.payModel.payPersonSid==nil || self.payModel.referPersonsSid==nil) {
        return;
    }
    
    
    if (self.finishBlock) {
        self.finishBlock(self.payModel);
    }
}

-(BOOL)isEmptyString:(NSString *)content{
    if (content == nil || content.length == 0) {
        return YES;
    }
    return NO;
}

@end
