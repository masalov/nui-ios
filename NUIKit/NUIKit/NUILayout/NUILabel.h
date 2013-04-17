//
//  NUILabel.h
//  NUILayout
//
//  Created by Ivan Masalov on 4/4/12.
//  Copyright (c) 2012 Noveo Group. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! Overrides \b preferredSizeThatFits: method and set \b needsToUpdateSize to \b YES on changes. */
@interface NUILabel : UILabel

- (CGSize)preferredSizeThatFits:(CGSize)size;

@end
