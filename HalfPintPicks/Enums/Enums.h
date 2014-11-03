//
//  Enums.h
//  HalfPintPicks
//
//  Created by TechCronus on 01/10/14.
//  Copyright (c) 2014 TechCronus. All rights reserved.
//

#ifndef HalfPintPicks_Enums_h
#define HalfPintPicks_Enums_h

//While we send one request for fetching or posting data to server we have to pass requestIs as parameter
typedef enum CurrentRequestIds {
    FirstRequest = 1,
    SecondRequest = 2,
    ThirdRequest = 3,
    ForthRequest = 4,
    FifthRequest = 5,
    SixthRequest = 6,
    SeventhRequest = 7,
    EightRequest = 8
} RequestId;

//This enum is for status of requests
typedef enum RequestStatus {
    Success = 1,
    Fail = 0,
    Error = 2
} Status;

//Indexs for Segment controls
typedef enum SelectedIndex {
    FirstIndex = 1,
    SecondIndex = 2,
    ThirdIdex = 3
} CurrentSelectedIndex;

#endif
