//
//  Event.h
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
<goalDeviation xsi:type="xsd:int">43200</goalDeviation>
<schedTime xsi:type="xsd:int">66586</schedTime>
<timestamp xsi:type="xsd:long">1223688694648</timestamp>
<goalTime xsi:type="xsd:int">-1</goalTime>
<type xsi:type="xsd:string">d</type>
<distanceToGoal xsi:type="xsd:int">-717</distanceToGoal>
<destination xsi:type="xsd:string">North Seattle - Leary Ave NW and NW Vernon Pl</destination>
*/

@interface Event : NSObject {
  NSInteger goalDeviation;
  NSInteger schedTime;
  NSInteger goalTime;
  NSString * type;
  NSInteger distanceToGoal;
  NSString * destination;
}

@property NSInteger goalDeviation;
@property NSInteger schedTime;
@property NSInteger goalTime;
@property NSInteger distanceToGoal;

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * destination;

@end
