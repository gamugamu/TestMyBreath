//
//  BAMolecularDataList.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 31/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAMolecularDataList.h"
#import "BAAnalyser.h"
#import "BAColorPicker.h"

@interface BAConcreteList : UIView
- (id)initWithData:(NSString*)moleculeName percent:(NSNumber*)percent andColor:(UIColor*)color intoFrame:(CGRect)frame;
@end

@implementation BAMolecularDataList
#pragma mark alloc/dealloc
#define BA_L_Space 30
- (id)initWithMolecularList:(NSDictionary*)molecularData intoFrame:(CGRect)frame{
    if ((self = [super initWithFrame: frame])) {
        // Initialization code
		[self setBackgroundColor: [UIColor clearColor]];
		NSDictionary* list		= [molecularData objectForKey: BAList_Molecular];
		NSDictionary* percent	= [molecularData objectForKey: BAPercent];
		__block int i			= 0;

		[list enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
			NSNumber* percent_ = [percent objectForKey: key];
			BAConcreteList* data = [[BAConcreteList alloc] initWithData: obj 
																percent: percent_ 
															   andColor: [BAColorPicker swatchColor: [key intValue]]
															  intoFrame: CGRectMake(0, BA_L_Space * i++, 200, BA_L_Space - 2)];
			[self addSubview: data];
			[data release];
		}];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
}

@end

@interface BAConcreteList()
@property(nonatomic, retain)UIColor* _color;
@end

@implementation BAConcreteList
@synthesize _color;

#define BAFutura		@"Futura-CondensedMedium"
#define BAFontlistSize	15
- (void)addLabel:(NSString*)name_{
	UIFont* font	= [UIFont fontWithName: BAFutura size: BAFontlistSize];
	UILabel* name	= [[UILabel alloc] initWithFrame: CGRectMake(70, 0, 150, BA_L_Space)];
	name.font		= font;
	name.text		= name_;
	[name setBackgroundColor: [UIColor clearColor]];
	[self addSubview: name];
	[name release];
}

#define BABoldFutura		@"Futura-CondensedExtraBold"
#define BAFontPercentSize	20
- (void)addPercent:(NSNumber*)percent_{
	UIFont* font			= [UIFont fontWithName: BAFutura size: BAFontPercentSize];
	UILabel* percent		= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, BA_L_Space)];
	percent.textAlignment	= UITextAlignmentRight;
	percent.font			= font;
	percent.text			= [NSString stringWithFormat:@"%@%%", percent_];
	[percent setBackgroundColor: [UIColor clearColor]];
	[self addSubview: percent];
	[percent release];
}

- (void)drawRect:(CGRect)rect{
	CGContextRef ctx	= UIGraphicsGetCurrentContext();
	CGRect rrect		= CGRectMake(45, 5, 20, 20); 
	CGFloat radius		= 2.0; 
	const CGFloat* cmp	= CGColorGetComponents([_color CGColor]);	
	CGFloat minx		= CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect); 
	CGFloat miny		= CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect); 
	
	CGContextSetRGBFillColor(ctx, cmp[0], cmp[1], cmp[2], cmp[3]);
	CGContextMoveToPoint(ctx, minx, midy); 
	CGContextAddArcToPoint(ctx, minx, miny, midx, miny, radius); 
	CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, radius); 
	CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, radius); 
	CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, radius); 
	CGContextClosePath(ctx); 
	CGContextFillPath(ctx);
}

- (id)initWithData:(NSString*)moleculeName percent:(NSNumber*)percent andColor:(UIColor*)color intoFrame:(CGRect)frame{
	if((self = [super initWithFrame: frame])){
		[self setBackgroundColor:[UIColor clearColor]];
		[self addLabel: moleculeName];
		[self addPercent: percent];
		[self set_color: color];
		[self setNeedsDisplay];
	}
	return self;
}

- (void)dealloc{
	[_color release];
	[super dealloc];
}
@end