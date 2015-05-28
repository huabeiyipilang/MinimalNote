//
//  LineTextView.m
//  MinimalNote
//
//  Created by Carl Li on 5/5/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "LineTextView.h"

@implementation LineTextView

- (id)initWithCoder:(NSCoder *)aDecoder{
    LineTextView* instance = [super initWithCoder:aDecoder];
//    self.delegate = self;
//    [self updateLineSpacing];
    return instance;
}

-(void)textViewDidChange:(UITextView *)textView{
    [self updateLineSpacing];
}

- (void)updateLineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 22;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
}

//- (void)drawRect:(CGRect)rect {
//    
//    //Get the current drawing context
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //Set the line color and width
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f].CGColor);
//    CGContextSetLineWidth(context, 1.0f);
//    
//    
//    //Start a new Path
//    CGContextBeginPath(context);
//    
//    //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
//    NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font.leading;
//    
//    //Set the line offset from the baseline. (I'm sure there's a concrete way to calculate this.)
//    CGFloat baselineOffset = 8.0f;
//    
//    //iterate over numberOfLines and draw each line
//    for (int x = 1; x < numberOfLines; x++) {
//        
//        //0.5f offset lines up line with pixel boundary
//        CGContextMoveToPoint(context, self.bounds.origin.x+10, 24*x + 0.5f+ baselineOffset);
//        CGContextAddLineToPoint(context, self.bounds.size.width-10, 24*x + 0.5f + baselineOffset);
//    }
//    
//    //Close our Path and Stroke (draw) it
//    CGContextClosePath(context);
//    CGContextStrokePath(context);
//}

@end
