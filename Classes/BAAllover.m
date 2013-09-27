//
//  BAAllover.m
//  BreathAnalyser
//
//  Created by loïc Abadie on 08/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BAAllover.h"
#import "GGTween.h"

@implementation BAAllover

#define BAAlloverPic0 @"allOver0.png"
#define BAAlloverPic1 @"allOver1.png"

- (void)allover{
	CGSize size		= self.frame.size;
	
	for(int x = 0; x < 3; x++){
		for(int y = 0; y < 5; y++){
			UIImageView* image	= [[UIImageView alloc] initWithImage: 
								   [UIImage  imageNamed: (x%2 == y%2)? BAAlloverPic0 : BAAlloverPic1]];
			float halfWidth		= image.frame.size.width/2;
			float halfHeight	= image.frame.size.height/2;
			float distanceX		= -halfWidth + (size.width/3 + halfWidth) * x;
			float distanceY		= -halfHeight + (size.height/5 + halfHeight) * y;
			image.center	= (CGPoint){distanceX, distanceY};
			
			[GGTween tween: image.layer 
						to: GGVectorMake(image.center.x + size.width/3 + image.frame.size.width/2,
										 image.center.y + size.height/5 + image.frame.size.height/2)
					  data: GGTweenDataMake(1, 2, 0, 0, ggTweenPosition, ggTweenLinear, MAXFLOAT, 0, NO)];

			[self addSubview: image];
				[image release];
		}
	}
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self allover];
    }
    return self;
}

@end
